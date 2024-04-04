class AddUserIdToPlaydateParticipants < ActiveRecord::Migration[7.1]
  def change
    add_reference :playdate_participants, :user, null: false, foreign_key: true
  end
end
