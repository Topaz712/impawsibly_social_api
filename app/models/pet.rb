class Pet < ApplicationRecord
  validates :name, :species, :breed, :sex, :birthday, :bio, presence: true
  validates :is_vaccinated, :is_fixed, presence: true, inclusion: { in: [true, false] }
  validates :birthday_age, numericality: { greater_than: 0 }

  belongs_to :user

  # associations
  has_many :posts, dependent: :destroy

  # playdate events the pet is participating in
  has_many :playdate_participants
  has_many :playdates, through: :playdate_participants
  
  has_one :profile, dependent: :destroy
  # after_create :create_profile

  has_many :sent_friendship_requests, class_name: 'FriendshipRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_friendship_requests, class_name: 'FriendshipRequest', foreign_key: 'recipient_id', dependent: :destroy

  has_many :friendships, foreign_key: 'pet_id', dependent: :destroy
  has_many :friends, through: :friendships, source: :friend

  private 

  def birthday_age
    ((Time.zone.now - birthday.to_time) / 1.year.seconds).floor
  end
end
