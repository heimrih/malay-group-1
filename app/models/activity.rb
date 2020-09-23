class Activity < ApplicationRecord
  enum field: {mark: 0, like: 1, report: 2}

  belongs_to :user
  belongs_to :post

  scope :field, (lambda |field| do
    where(field: fields[field])
  end)
end
