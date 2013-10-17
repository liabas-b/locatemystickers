class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :owner_id
      t.integer :sticker_id

      t.timestamps
    end

    add_index :relationships, :follower_id
    add_index :relationships, :owner_id
  end
end
