class AddVersionToStickers < ActiveRecord::Migration
  def change
  	add_column :stickers, :version, :integer, default: 0
  end
end
