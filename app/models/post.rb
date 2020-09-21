class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_rich_text :body

  scope :sort_by_time, ->{order created_at: :desc}
end
