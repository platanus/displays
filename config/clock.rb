require 'clockwork'
require './config/environment'

SSE_PING_INTERVAL = ENV.fetch('SSE_PING_INTERVAL').to_i.seconds

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(SSE_PING_INTERVAL, 'display.ping', thread: true) do
    redis = Redis.new
    redis.publish('display:ping', Time.now)
  end
end
