class RemovePetIdFromComments < ActiveRecord::Migration[7.1]
  def change
    remove_column :comments, :pet_id, :integer
  end
end
