class RemoveProfileIdFromPets < ActiveRecord::Migration[7.1]
  def change
    remove_column :pets, :profile_id, :integer
  end
end
