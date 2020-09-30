class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_rich_text :body

  scope :sort_by_time, ->{order created_at: :desc}
  scope :lastest, ->{order created_at: :desc}
  scope :by_top, ->(topic_id){where topic_id: topic_id if topic_id.present?}
end
