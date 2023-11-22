# spec/models/product_type_spec.rb
require 'rails_helper'

RSpec.describe ProductType, type: :model do
  it 'is a Mongoid document' do
    is_expected.to be_mongoid_document
  end

  it 'has a field named name of type String' do
    is_expected.to have_field(:name).of_type(String)
  end

  describe 'validations' do
    let(:duplicate_product_type) { ProductType.new(name: 'UniqueName') }
    it { is_expected.to validate_presence_of(:name) }

    before { ProductType.create!(name: 'UniqueName') }

    it 'validates uniqueness of name' do
      expect(duplicate_product_type.valid?).to be false
      expect(duplicate_product_type.errors[:name]).to include('has already been taken')
    end
  end

  it 'has a unique index on name' do
    is_expected.to have_index_for(name: 1).with_options(unique: true)
  end

  describe 'associations' do
    let(:product_type) { ProductType.new(name: 'Example Type') }
    let(:product) { Product.new(name: 'Example Product', length: 10, width: 10, height: 10, weight: 10, product_type: product_type) }

    it 'has many products' do
      expect(product_type.products).to include(product)
    end
  end
end
