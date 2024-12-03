FactoryBot.define do
  factory :equation do
    position_a { 1 }
    position_b { 1 }
    position_c { 1 }
    operator { "MyString" }
    unknown_position { "MyString" }
    collection { nil }
  end
end
