class Activity < ApplicationRecord
  enum field: {mark: 0, like: 1, report: 2}

  belongs_to :user
  belongs_to :post

  scope :field, ->(field) {where(field: fields[field])}
end
