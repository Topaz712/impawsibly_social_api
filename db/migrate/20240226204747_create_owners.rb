class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_information
      t.references :user, null: false, foreign_key: true

      # adds a unique index on user_id column
      add_index :owners, :user_id, unique: true
      
      t.timestamps
    end
  end
end
