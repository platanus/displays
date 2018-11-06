class DisplaysController < ApplicationController
  include ActionController::Live

  decorates_assigned :display

  def show
    @display = Display.where(host_uuid: params[:host_uuid])
                      .first_or_create

    render layout: false
  end

  def watch
    display = Display.find_by(host_uuid: params[:host_uuid])

    stream.write(display.event_data.to_json, event: 'display_connected')

    event_stream('display:*') do |event, data|
      case event
      when 'display:updated'
        stream.write(data, event: 'display_updated') if from_current_display? data
      when 'display:ping'
        stream.write('pong', event: 'display_ping')
      when 'display:disconnect'
        stream.write(nil, event: 'display_disconnected')
        stream.close
      end
    end

    render body: nil
  end

  def setup
    @display = Display.find_by(host_uuid: params[:host_uuid])
  end

  private

  def from_current_display?(_data)
    params[:host_uuid] == JSON.parse(_data)['host_uuid']
  end

  def event_stream(channel, &_block)
    response.headers['Content-Type'] = 'text/event-stream'

    redis.psubscribe(channel) do |on|
      on.pmessage do |_, event, data|
        yield(event, data)
      end
    end
  rescue IOError
  rescue ClientDisconnected
    logger.info("Client Disconnected")
  ensure
    stream.close
    redis.quit
  end

  def stream
    @sse ||= SSE.new(response.stream)
  end

  def redis
    @redis ||= Redis.new
  end
end
