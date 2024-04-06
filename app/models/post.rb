class Post < ApplicationRecord
  include Rails.application.routes.url_helpers
  
  # active storage
  has_many_attached :images

  # validations
  validates :content, presence: true, length: {maximum: 2500}

  # associations
  belongs_to :pet
  has_many :comments, as: :commentable, dependent: :destroy

  def post_image_url
    # url helpers
    rails_blob_url(self.images, only_path: false) if self.images.attached?
  end
end
