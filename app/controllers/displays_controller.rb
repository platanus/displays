class DisplaysController < ApplicationController
  include ActionController::Live

  decorates_assigned :display

  def show
    @display = Display.where(host_uuid: params[:host_uuid])
                      .first_or_create
  end

  def watch
    event_stream('display:*') do |event, data|
      case event
      when 'display:updated'
        stream.write(data, event: 'display_updated') if from_current_display? data
      when 'display:ping'
        stream.write('pong', event: 'display_ping')
      end
    end

    render body: nil
  end

  def setup
    @display = Display.where(host_uuid: params[:host_uuid])
                      .first_or_create
  end

  private

  def from_current_display?(_data)
    params[:host_uuid] == JSON.parse(_data)['host_uuid']
  end

  def event_stream(channel, &_block)
    response.headers['Content-Type'] = 'text/event-stream'

    redis = Redis.new
    redis.psubscribe(channel) do |on|
      on.pmessage do |_, event, data|
        yield(event, data)
      end
    end

    stream.write(nil, event: 'display_connected')
  rescue ClientDisconnected
    logger.info("Stream closed")
  ensure
    stream.close
    redis.quit
  end

  def stream
    @sse ||= SSE.new(response.stream)
  end
end
