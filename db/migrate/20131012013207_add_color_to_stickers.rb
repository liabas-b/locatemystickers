class AddColorToStickers < ActiveRecord::Migration
  def change
    add_column :stickers, :color, :string
  end
end
