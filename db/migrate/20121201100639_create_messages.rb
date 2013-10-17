class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :from_user_id
      t.string :subject
      t.string :content

      t.timestamps
    end
  end
end
