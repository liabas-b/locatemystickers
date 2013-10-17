class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.integer :sticker_id
      t.float :latitude
      t.float :longitude
      t.boolean :gmaps

      t.timestamps
    end

  	add_index :locations, :sticker_id
  end
end
