class PlaydateParticipant < ApplicationRecord
  # rating can be nil initially
  validates :rating, inclusion: { in: 1..5 }, allow_nil: true 

  belongs_to :user
  belongs_to :pet
  belongs_to :playdate
end
