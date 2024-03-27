class Profile < ApplicationRecord
  validates :bio, presence: true, length: {maximum:2000}

  belongs_to :owner
  belongs_to :pet, optional: true

  has_many :posts
end
