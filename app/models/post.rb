class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2500}

  # associations
  belongs_to :pet_profile, class_name: 'Profile'
  has_many :comments, as: :commentable, dependent: :destroy
end
