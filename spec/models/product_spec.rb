require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'is a Mongoid document' do
    is_expected.to be_mongoid_document
  end

  it 'has fields for name, length, width, height, and weight' do
    is_expected.to have_field(:name).of_type(String)
    is_expected.to have_field(:length).of_type(Integer)
    is_expected.to have_field(:width).of_type(Integer)
    is_expected.to have_field(:height).of_type(Integer)
    is_expected.to have_field(:weight).of_type(Integer)
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_numericality_of(:length).only_integer.is_greater_than(0) }
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_numericality_of(:width).only_integer.is_greater_than(0) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_numericality_of(:height).only_integer.is_greater_than(0) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:weight).only_integer.is_greater_than(0) }
  end

  it 'has a unique index on name' do
    is_expected.to have_index_for(name: 1).with_options(unique: true)
  end

  describe 'associations' do
    it 'belongs to product_type' do
      product_type = ProductType.create(name: 'Example Type')
      product = Product.new(name: 'Example Product', length: 10, width: 10, height: 10, weight: 10, product_type: product_type)

      expect(product.product_type).to eq(product_type)
    end
  end

  describe 'uniqueness validation' do
    let!(:product_type) { ProductType.find_or_create_by(name: 'Example Type') }

    it 'does not allow duplicate names' do
      Product.create(name: 'UniqueName', length: 1, width: 1, height: 1, weight: 1, product_type: product_type)
      duplicate_product = Product.new(name: 'UniqueName', length: 2, width: 2, height: 2, weight: 2, product_type: product_type)
      expect(duplicate_product.valid?).to be false
      expect(duplicate_product.errors[:name]).to include('has already been taken')
    end
  end
end
