class AddLatitudeAndLongitudeToStickers < ActiveRecord::Migration
  def change
    add_column :stickers, :last_longitude, :float
    add_column :stickers, :last_latitude, :float
  end
end
