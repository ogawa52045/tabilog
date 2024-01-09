class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :member
  
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
end
