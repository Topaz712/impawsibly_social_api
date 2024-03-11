class Profile < ApplicationRecord
  validates :bio, presence: true

  belongs_to :owner
  belongs_to :pet, optional: true
end
