class AddPetIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :pet, null: false, foreign_key: true
  end
end
