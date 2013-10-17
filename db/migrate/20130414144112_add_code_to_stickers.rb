class AddCodeToStickers < ActiveRecord::Migration
  def change
    add_column :stickers, :code, :string
    add_index :stickers, :code, unique: true
  end
end
