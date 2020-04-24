class Address < ApplicationRecord
  belongs_to :user
  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :street, presence: true
  validates :user, presence: true

end
