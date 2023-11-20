# lib/tasks/import.rake
require 'json'

namespace :db do
  desc "Import products from a JSON file"
  task import_products: :environment do
    file = File.read(Rails.root.join('products.json'))
    products = JSON.parse(file)["products"]
    count = 0

    products.each do |product_data|
      product_type = ProductType.find_or_create_by(name: product_data["type"])
      p = Product.find_or_initialize_by(
        name: product_data["name"],
        product_type: product_type,
        length: product_data["length"],
        width: product_data["width"],
        height: product_data["height"],
        weight: product_data["weight"]
      )
      count += 1 if !p.persisted? && p.save
    end

    puts "Imported #{count} products"
  end
end
