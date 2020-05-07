class Address < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  # 下記一行追加：外部キーがnullであることを許可するオプション
  belongs_to :user, optional: true
  # belongs_to :user, inverse_of: :address

  validates :postal_code, presence: true
  validates :prefecture_id, presence: true
  validates :city, presence: true
  validates :street, presence: true
  # validates :user, presence: true

end

