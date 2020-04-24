class CreditCard < ApplicationRecord
  belongs_to :user
  validates :card_number, presence: true
  validates :expiration_year, presence: true
  validates :expiration_month, presence: true
  validates :security_code, presence: true
  validates :card_name, presence: true
  validates :user, presence: true
end
