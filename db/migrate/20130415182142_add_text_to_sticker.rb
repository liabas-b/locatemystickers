class AddTextToSticker < ActiveRecord::Migration
  def change
    add_column :stickers, :text, :string
  end
end
