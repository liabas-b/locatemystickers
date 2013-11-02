class CreateAppRoutes < ActiveRecord::Migration
  def change
    create_table :app_routes do |t|
      t.string :name
      t.string :path
      t.string :method
      t.string :description
      t.string :goal
      t.string :title
      t.string :arguments
      t.string :extensions
      t.string :responses_status
      t.string :response_body
      t.string :example_request

      t.timestamps
    end
  end
end
