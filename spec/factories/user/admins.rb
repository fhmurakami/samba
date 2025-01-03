FactoryBot.define do
  factory :user_admin, class: User::Admin do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    email { FFaker::Internet.email }
    password { "password" }
    password_confirmation { "password" }
  end
end
