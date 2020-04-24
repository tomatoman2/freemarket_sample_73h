class Code < ApplicationRecord
  belongs_to :product
  validates :group_code_id, presence: true
  validates :group_code_name, presence: true
  validates :code_id, presence: true
  validates :code_name, presence: true
end
