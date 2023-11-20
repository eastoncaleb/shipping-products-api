FactoryBot.define do
  factory :product_type do
    name { "MyString" }
    string { "MyString" }
  end

  product_list = [
    "Small Package",
    "Large Package",
    "Extra Large Package",
    "Carry On",
    "Checked Bag",
    "Oversized Bag",
    "Ski Bag",
    "Snowboard Bag",
    "Double Ski Bag",
    "Double Snowboard Bag",
    "Snowboot Bag"
  ]

  type_list = [
    "Golf", "Luggage", "Ski"
  ]

  factory(:product) do
    name { product_list.sample }
    type { type_list.sample }
    length { rand(1..20) }
    width { rand(1..20) }
    height { rand(1..20) }
    weight { rand(1..20) }
  end
end
