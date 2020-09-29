class Activity < ApplicationRecord
  enum field: {mark: 0, like: 1, report: 2}

  belongs_to :user
  belongs_to :post

  has_many :notifications

  scope :field, ->(field) {where(field: fields[field])}
end
