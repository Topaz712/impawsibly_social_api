class RemoveOwnerIdFromPets < ActiveRecord::Migration[7.1]
  def change
    remove_column :pets, :owner_id, :integer
  end
end
