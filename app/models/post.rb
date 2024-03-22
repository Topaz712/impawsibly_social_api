class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2500}

  # associations
  belongs_to :profile
  has_many :comments, as: :commentable, dependent: :destroy
end
