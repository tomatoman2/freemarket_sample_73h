class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  has_many :credit_cards
  has_many :addresses
  has_many :likes
  has_many :coments
  has_many :Products
  has_many :orders

  validates :nickname,presence: true
  validates :kana_name,presence: true
  validates :birthday,presence: true
  validates :name,presence: true
end
