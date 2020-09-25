class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by, class_name: "User"
  belongs_to :post

  scope :sort_by_time, ->{order created_at: :desc}

  validates :user_id, :notified_by_id, :post_id, :notice_type, presence: true
end
