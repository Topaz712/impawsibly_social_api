class RemoveOwnerIdFromPlaydateParticipants < ActiveRecord::Migration[7.1]
  def change
    remove_column :playdate_participants, :owner_id, :integer
  end
end
