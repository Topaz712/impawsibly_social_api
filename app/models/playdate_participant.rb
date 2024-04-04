class PlaydateParticipant < ApplicationRecord
  belongs_to :user
  belongs_to :pet
  belongs_to :playdate
end
