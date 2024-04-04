class AddUserIdToPlaydates < ActiveRecord::Migration[7.1]
  def change
    add_reference :playdates, :user, null: false, foreign_key: true
  end
end
