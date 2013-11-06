class AddDateToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :date, :datetime
  end
end
