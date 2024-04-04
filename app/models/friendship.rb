class Friendship < ApplicationRecord
  validates :pet_id, :friend_id, presence: true

  belongs_to :pet

  belongs_to :friend, class_name: 'User'
end