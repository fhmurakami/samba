FactoryBot.define do
  factory :equation do
    position_a { 1 }
    position_b { 1 }
    position_c { 1 }
    operator { "*" }
    unknown_position { "a" }
    user_admin
  end
end
