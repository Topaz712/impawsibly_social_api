class CreateOwners < ActiveRecord::Migration[7.1]
  def change
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :contact_information
      t.references :user, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
