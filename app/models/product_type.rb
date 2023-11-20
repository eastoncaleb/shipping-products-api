class ProductType
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String

  has_many :products

  validates :name, presence: true, uniqueness: true

  index({ name: 1 }, { unique: true })
end
