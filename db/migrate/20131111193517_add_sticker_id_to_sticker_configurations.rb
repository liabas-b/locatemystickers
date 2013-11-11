class AddStickerIdToStickerConfigurations < ActiveRecord::Migration
  def change
    add_column :sticker_configurations, :sticker_id, :integer
  end
end
