class AddTagsAsStringToStickers < ActiveRecord::Migration
  def change
    add_column :stickers, :tags_as_string, :string
  end
end
