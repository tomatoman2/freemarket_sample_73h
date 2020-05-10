class Category < ApplicationRecord
  has_many :products
  validates :level, presence: true
  validates :name, presence: true

  def self.search_children(parent_id)
    Category.where(parent_id: parent_id)
  end

  def parent
    Category.find(self.parent_id)
  end
end
