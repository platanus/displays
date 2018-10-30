FactoryBot.define do
  factory :display do
    host_uuid { 'd23im0d' }

    trait :setup do
      name { 'my dashboard' }
      url { 'http://my.dashobard.com' }
    end
  end
end
