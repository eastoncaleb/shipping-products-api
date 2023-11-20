class ProductMatcher
  def self.find_best_match(length:, width:, height:, weight:)
    matching_products = Product.where(
      :length.gte => length,
      :width.gte => width,
      :height.gte => height,
      :weight.gte => weight
    )

    best_match = matching_products.min_by do |product|
      unused_space(product, length, width, height, weight)
    end

    best_match
  end

  private

  def self.unused_space(product, length, width, height, weight)
    (product.length - length) +
    (product.width - width) +
    (product.height - height) +
    (product.weight - weight)
  end
end
