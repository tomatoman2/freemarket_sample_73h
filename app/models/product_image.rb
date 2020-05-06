class ProductImage < ApplicationRecord
  validates :image_name, presence: true
  belongs_to :product
  mount_uploader :image_name, ImageUploader
end
