class AddVersionToLocations < ActiveRecord::Migration
  def change
  	add_column :locations, :version, :integer, default: 0
  end
end
