class Category < ApplicationRecord
  has_many :products
  validates :level, presence: true
  validates :name, presence: true

end
