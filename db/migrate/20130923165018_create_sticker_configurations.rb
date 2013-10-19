class CreateStickerConfigurations < ActiveRecord::Migration
  def change
    create_table :sticker_configurations do |t|
      t.string :sticker_code
      t.integer :frequency_update
      t.integer :activate

      t.timestamps
    end
  end
end
