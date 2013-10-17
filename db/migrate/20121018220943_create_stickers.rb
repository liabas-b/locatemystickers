class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.string :name
      t.integer :sticker_type_id, default: 1

      t.timestamps
    end
  end
end
