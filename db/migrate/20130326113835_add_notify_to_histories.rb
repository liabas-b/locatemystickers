class AddNotifyToHistories < ActiveRecord::Migration
  def change
  	add_column :histories, :notification_level, :integer, default: 0
  	add_column :histories, :notify, :integer, default: 0
  	add_column :histories, :notification_confirmed, :integer, default: 0
  end
end
