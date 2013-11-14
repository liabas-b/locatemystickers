class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :key
      t.integer :times_used
      t.float :popularity
      t.string :color
      t.boolean :forbidden
      t.string :scope

      t.timestamps
    end
  end
end
