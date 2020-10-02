class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  scope :lastest, ->{order created_at: :desc}
end
