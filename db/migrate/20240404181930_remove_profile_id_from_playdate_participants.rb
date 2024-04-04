class RemoveProfileIdFromPlaydateParticipants < ActiveRecord::Migration[7.1]
  def change
    remove_column :playdate_participants, :profile_id, :integer
  end
end
