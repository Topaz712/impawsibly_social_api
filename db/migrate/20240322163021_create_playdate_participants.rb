class CreatePlaydateParticipants < ActiveRecord::Migration[7.1]
  def change
    create_table :playdate_participants do |t|
      t.references :owner, null: false, foreign_key: true
      t.references :pet, null: false, foreign_key: true
      t.references :playdate, null: false, foreign_key: true
      t.integer :rating

      t.timestamps
    end
  end
end
