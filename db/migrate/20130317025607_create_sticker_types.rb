class CreateStickerTypes < ActiveRecord::Migration
  def change
    create_table :sticker_types do |t|
    	t.string :name
    	t.string :icon

      t.timestamps
    end
  end
end
