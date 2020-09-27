class Topic < ApplicationRecord
  has_many :posts
  scope :lastest, ->{order created_at: :desc}
end
