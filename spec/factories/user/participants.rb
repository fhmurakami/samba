FactoryBot.define do
  factory :user_participant, class: 'User::Participant' do
    first_name { "MyString" }
    last_name { "MyString" }
    birth_date { "2024-11-22" }
    user_admin { nil }
  end
end
