class CreateFriendshipRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :friendship_requests do |t|
      t.references :sender, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: true
      t.references :friendship, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
