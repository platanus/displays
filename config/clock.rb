require 'clockwork'
require './config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(2.seconds, 'display.ping', thread: true) do
    redis = Redis.new
    redis.publish('display:ping', Time.now)
  end
end
