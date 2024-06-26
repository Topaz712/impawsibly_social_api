class Pet < ApplicationRecord
  include Rails.application.routes.url_helpers
  validates :name, :species, :breed, :sex, :birthday, :bio, presence: true
  validates :is_vaccinated, :is_fixed, presence: true, inclusion: { in: [true, false] }
  

  belongs_to :user

  # active storage
  has_one_attached :avatar_image

  # associations
  has_many :posts, dependent: :destroy

  # playdate events the pet is participating in
  has_many :playdate_participants
  has_many :playdates, through: :playdate_participants

  has_many :sent_friendship_requests, class_name: 'FriendshipRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_friendship_requests, class_name: 'FriendshipRequest', foreign_key: 'recipient_id', dependent: :destroy

  has_many :friendships, foreign_key: 'pet_id', dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  def avatar_image_url
    # url helpers
    rails_blob_url(self.avatar_image, only_path: false) if self.avatar_image.attached?
  end

  private 


  def birthday_age
    ((Time.zone.now - birthday.to_time) / 1.year.seconds).floor
  end
end
