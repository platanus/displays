class DisplaysController < ApplicationController
  include ActionController::Live

  PING_INTERVAL = 45

  def show
    @display = Display.find(params[:id])
  end

  def watch
    begin
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)

      ping = Concurrent::TimerTask.new(execution_interval: PING_INTERVAL) do
        sse.write('pong', event: "display_ping")
      end
      ping.execute

      redis = Redis.new
      redis.subscribe('display:updated') do |on|
        on.message do |e, data|
          sse.write(data, event: "display_updated") if from_current_display? data
        end
      end
    rescue ClientDisconnected
    ensure
      sse.close
      redis.quit
      ping.shutdown
    end

    render nothing: true
  end

  private

  def from_current_display? _data
    params[:id].to_i == JSON.parse(_data)['id']
  end
end
