class Category < ApplicationRecord
  has_many :products
  validates :class, presence: true
  validates :parent_id
  validates :name, presence: true

end
