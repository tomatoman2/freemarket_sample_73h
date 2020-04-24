class ProductImage < ApplicationRecord
  validates :image_name, presence: true

  belongs_to :product
end
