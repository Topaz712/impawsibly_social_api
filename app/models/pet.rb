class Pet < ApplicationRecord
  validates :name, :species, :breed, :sex, :birthday, :is_vaccinated, :is_fixed, presence: true

  belongs_to :owner

  has_many :sent_friendship_requests, class_name: 'FriendshipRequest', foreign_key: 'sender_id', dependent: :destroy
  has_many :received_friendship_requests, class_name: 'FriendshipRequest', foreign_key: 'recipient_id', dependent: :destroy

  has_many :friendships, foreign_key: 'pet_id', dependent: :destroy
  has_many :friends, through: :friendships, source: :friend
end
