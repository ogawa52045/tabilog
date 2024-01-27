class Destination < ApplicationRecord
  belongs_to :post
  has_many :reviews, dependent: :destroy
end
