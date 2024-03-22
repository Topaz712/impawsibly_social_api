class CreateFriendshipRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :friendship_requests do |t|
      t.integer :sender_id, null: false
      t.integer :recipient_id, null: false
      # t.references :friendship, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
