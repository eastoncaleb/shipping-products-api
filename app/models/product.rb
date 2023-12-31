class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  belongs_to :product_type

  validates :name, presence: true, uniqueness: true
  validates :length, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :width, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :height, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :weight, presence: true, numericality: { only_integer: true, greater_than: 0 }

  index({ name: 1 }, { unique: true })
end
