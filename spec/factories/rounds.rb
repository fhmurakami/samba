FactoryBot.define do
  factory :round do
    collection
    association :participant, factory: :user_participant
    started_at { "2024-12-06 14:52:50" }
    completed_at { "2024-12-06 14:52:50" }
  end
end
