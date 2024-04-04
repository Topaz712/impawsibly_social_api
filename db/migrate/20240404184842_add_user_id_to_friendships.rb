class AddUserIdToFriendships < ActiveRecord::Migration[7.1]
  def change
    add_reference :friendships, :user, null: false, foreign_key: true
  end
end
