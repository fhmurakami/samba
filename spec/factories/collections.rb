FactoryBot.define do
  factory :collection do
    name { "MyCollection" }
    equations_quantity { 1 }
    user_admin
  end
end
