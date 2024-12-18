FactoryBot.define do
  factory :round do
    collection
    association :participant, factory: :user_participant
    started_at { "2024-12-06 14:00:00" }
    completed_at { "2024-12-06 14:02:50" }
  end
end
