class AddTaggableToStickers < ActiveRecord::Migration
  def change
      add_column :tags, :taggable_type, :string
      add_column :tags, :taggable_id, :integer
  end
end
