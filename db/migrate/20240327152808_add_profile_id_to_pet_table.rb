class AddProfileIdToPetTable < ActiveRecord::Migration[7.1]
  def change
    add_reference :pets, :profile, foreign_key: true
  end
end
