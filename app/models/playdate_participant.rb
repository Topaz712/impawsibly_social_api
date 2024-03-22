class PlaydateParticipant < ApplicationRecord
  belongs_to :owner
  belongs_to :pet
  belongs_to :playdate
end
