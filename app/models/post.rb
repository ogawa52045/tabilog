class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :member
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one :destination
  accepts_nested_attributes_for :destination
  
  validates :title, presence: true
  validates :content, presence: true
  validates :image, presence: true
  
  def favorited_by?(member)
    favorites.exists?(member_id: member.id)
  end
  
  
end
