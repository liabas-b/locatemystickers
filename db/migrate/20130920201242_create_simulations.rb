class CreateSimulations < ActiveRecord::Migration
  def change
    create_table :simulations do |t|
      t.integer :user_id
      t.integer :sticker_id
      t.integer :locations_sent
      t.string :description

      t.timestamps
    end
  end
end
