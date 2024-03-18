class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.references :pet, null: false, foreign_key: true
      t.references :commentable, polymorphic: true, null: false
      t.text :content

      t.timestamps
    end
  end
end
