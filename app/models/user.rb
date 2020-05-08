class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
        
  has_many :credit_cards
  # has_many :addresses, inverse_of: :user
  has_many :likes
  has_many :coments
  has_many :products
  has_many :orders
  # カリキュラムに従い下記一行に変更
  has_one :address
  # has_many :addresses
  # 下記をコメントアウト
  # accepts_nested_attributes_for :addresses


  # belongs_to :user, inverse_of: :address

  # has_many :addresses, inverse_of: :user
  # belongs_to :address, inverse_of: :user
  # accepts_nested_attributes_for :addresses

  validates :nickname,presence: true
  validates :family_name,presence: true
  validates :first_name,presence: true
  validates :kana_family_name,presence: true
  validates :kana_first_name,presence: true
  validates :birthday,presence: true

end
