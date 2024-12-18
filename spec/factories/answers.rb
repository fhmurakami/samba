FactoryBot.define do
  factory :answer do
    association :participant, factory: :user_participant
    collection_equation
    round
    answer_value { 1 }
    correct_answer { true }
    time_spent { 10.seconds.in_milliseconds }

    trait :incorrect do
      correct_answer { false }
    end

    trait :invalid do
      round { nil }
    end
  end
end
