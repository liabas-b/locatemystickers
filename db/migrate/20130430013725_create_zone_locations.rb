class CreateZoneLocations < ActiveRecord::Migration
  def change
    create_table :zone_locations do |t|
      t.integer :zone_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
