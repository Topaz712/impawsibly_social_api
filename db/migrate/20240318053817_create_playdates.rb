class CreatePlaydates < ActiveRecord::Migration[7.1]
  def change
    create_table :playdates do |t|
      t.references :owner, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.text :title
      t.text :content
      t.boolean :species_specific
      t.integer :pet_limit
      t.datetime :start_date_time
      t.datetime :end_date_time

      t.timestamps
    end
  end
end
