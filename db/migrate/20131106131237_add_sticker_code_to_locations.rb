class AddStickerCodeToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :sticker_code, :string
  end
end
