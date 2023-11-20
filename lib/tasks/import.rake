require 'json'

namespace :db do
  desc "Import products from a JSON file"
  task import_products: :environment do
    file = File.read(Rails.root.join('products.json'))
    products = JSON.parse(file)["products"]

    products.each do |product_data|
      Product.create!(
        name: product_data["name"],
        type: product_data["type"],
        length: product_data["length"],
        width: product_data["width"],
        height: product_data["height"],
        weight: product_data["weight"]
      )
    end

    puts "Imported #{products.size} products"
  end
end
