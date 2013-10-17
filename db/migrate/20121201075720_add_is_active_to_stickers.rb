class AddIsActiveToStickers < ActiveRecord::Migration
  def change
  	add_column :stickers, :is_active, :boolean, default: false
  end
end
