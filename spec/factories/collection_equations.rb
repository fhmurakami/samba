FactoryBot.define do
  factory :collection_equation do
    collection
    equation

    trait :invalid do
      equation { nil }
    end
  end
end
