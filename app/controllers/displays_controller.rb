class DisplaysController < ApplicationController
  include ActionController::Live

  def show
    @display = Display.find(params[:id])
  end

  def watch
    begin
      sse = SSE.new(response.stream, event: 'time')
      response.headers['Content-Type'] = 'text/event-stream'

      redis = Redis.new
      redis.subscribe('display:updated') do |on|
        on.message do |e, data|

          sse.write(data, event: "url_changed")
        end
      end
    rescue ClientDisconnected
    ensure
      sse.close
      redis.quit
    end

    render nothing: true
  end
end
