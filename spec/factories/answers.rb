FactoryBot.define do
  factory :answer do
    user_participant { nil }
    equation { nil }
    answer_value { 1 }
    correct_answer { false }
    time { "2024-12-04 19:39:16" }
  end
end
