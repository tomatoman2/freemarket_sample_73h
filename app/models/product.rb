class Product < ApplicationRecord
  validates :name, presence: true
  validates :category_id, presence: true
  validates :price, presence: true
  validates :postage_code, presence: true
  validates :explanation, presence: true
  validates :status, presence: true
  validates :prefecture_id, presence: true
  validates :delivery_time_code, presence: true

  has_many :likes
  has_many :comments
  has_many :product_images
  belongs_to :order
  belongs_to :user
  belongs_to :brand
  belongs_to :category
  belongs_to :code

  accepts_nested_attributes_for :product_images, allow_destroy: true
end
