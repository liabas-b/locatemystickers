class AddActionToAppRoutes < ActiveRecord::Migration
  def change
    add_column :app_routes, :action, :string
  end
end
