class Display < ApplicationRecord
  after_update :notify_display_changed

  def notify_display_changed
    redis = Redis.new
    redis.publish('display:updated', event_data.to_json)
  end

  def event_data
    {
      name: name,
      host_uuid: host_uuid,
      url: decorate.present_url
    }
  end
end

# == Schema Information
#
# Table name: displays
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  host_uuid  :string
#
# Indexes
#
#  index_displays_on_host_uuid  (host_uuid) UNIQUE
#
