class DropOwner < ActiveRecord::Migration[7.1]
  def change
    if table_exists?(:owners)
      drop_table :owners
    end
  end
end
