FactoryBot.define do
  factory :product_type do
    name { Faker::Name.unique.name }
  end

  factory(:product) do
    association :product_type
    name { Faker::Name.unique.name }
    length { rand(1..20) }
    width { rand(1..20) }
    height { rand(1..20) }
    weight { rand(1..20) }
  end
end
