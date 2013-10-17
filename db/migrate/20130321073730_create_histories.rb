class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.string :subject
      t.string :operation
      t.integer :user_id, default: 0
      t.integer :sticker_id, default: 0
      t.integer :location_id, default: 0
      t.integer :message_id, default: 0

      t.timestamps
    end
  end
end
