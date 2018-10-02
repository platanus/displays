class DisplaysController < ApplicationController
  include ActionController::Live

  PING_INTERVAL = 25

  def show
    @display = Display.where(host_uuid: params[:host_uuid])
      .first_or_create
  end

  def watch
    begin
      response.headers['Content-Type'] = 'text/event-stream'
      sse = SSE.new(response.stream)

      ping = Concurrent::TimerTask.new(execution_interval: PING_INTERVAL, run_now: true) do
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

  def setup
    @display = Display.where(host_uuid: params[:host_uuid])
      .first_or_create
  end

  private

  def from_current_display? _data
    params[:host_uuid] == JSON.parse(_data)['host_uuid']
  end
end
