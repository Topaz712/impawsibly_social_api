class AddProfileIdToPetTable < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:profiles)
      add_reference :pets, :profile, foreign_key: true
    end
  end
end
