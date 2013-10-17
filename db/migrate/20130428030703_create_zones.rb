class CreateZones < ActiveRecord::Migration
  def change
    create_table :zones do |t|
      t.string :name
      t.string :description
      t.integer :alert_level
      t.integer :alerts_on_enter
      t.integer :alerts_on_exit
      t.integer :sticker_id
      t.string :colour

      t.timestamps
    end
  end
end
