class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  
  # active storage
  has_many_attached :images

  # validations
  validates :content, presence: true, length: {maximum: 2500}

  # associations
  belongs_to :pet
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes

  def liked?(user)
    # checks if user already liked the post/returns true or false
    !!self.likes.find{|like| like.user.id == user.id}
  end

  def post_image_url
    # url helpers
    rails_blob_url(self.images, only_path: false) if self.images.attached?
  end
end
