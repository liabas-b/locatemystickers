class AddIsNewToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :is_new, :boolean
  end
end
