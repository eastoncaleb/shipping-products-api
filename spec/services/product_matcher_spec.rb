require 'rails_helper'

RSpec.describe ProductMatcher do
  describe '.find_best_match' do
    let!(:product_type) { create(:product_type) }
    let!(:product1) { create(:product, product_type: product_type, length: 10, width: 10, height: 10, weight: 10) }
    let!(:product2) { create(:product, product_type: product_type, length: 15, width: 15, height: 15, weight: 15) }

    it 'returns the product with the smallest unused space' do
      best_match = ProductMatcher.find_best_match(length: 9, width: 9, height: 9, weight: 9)
      expect(best_match).to eq(product1)
    end

    it 'returns nil if no products match the given dimensions' do
      best_match = ProductMatcher.find_best_match(length: 100, width: 100, height: 100, weight: 100)
      expect(best_match).to be_nil
    end
  end
end
