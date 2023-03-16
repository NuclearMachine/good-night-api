FactoryBot.define do
  factory :sleep_record do
    user

    start_time { Time.current }
    end_time { Time.current + 8.hours }
  end
end
