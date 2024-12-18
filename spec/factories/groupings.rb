FactoryBot.define do
  factory :grouping do
    name { FFaker::FreedomIpsum.word }
    user_admin
  end
end
