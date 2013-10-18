class AddLastLocationToSticker < ActiveRecord::Migration
  def change
    add_column :stickers, :last_location, :string
  end
end
