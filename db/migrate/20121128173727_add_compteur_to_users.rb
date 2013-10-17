class AddCompteurToUsers < ActiveRecord::Migration
  def change
    add_column :users, :compteur, :integer, default: 0
  end
end
