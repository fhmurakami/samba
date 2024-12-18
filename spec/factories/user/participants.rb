FactoryBot.define do
  factory :user_participant, class: User::Participant do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    birth_date { FFaker::Date.birthday(min_age: 5) }
    grouping { build(:grouping) }
    user_admin


    trait :with_answers do
      answers
    end
  end
end
