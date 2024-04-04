class RemoveProfileIdFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :profile_id, :integer
  end
end
