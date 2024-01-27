class Review < ApplicationRecord
  belongs_to :destination
  belongs_to :member
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1}, presence: true
end
