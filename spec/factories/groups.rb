FactoryBot.define do
  factory :group do
    name { FFaker::FreedomIpsum.word }
    user_admin
  end
end
