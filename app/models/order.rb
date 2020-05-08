class Order < ApplicationRecord
  belongs_to :user
  has_one :product
end
