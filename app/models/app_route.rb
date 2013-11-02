class AppRoute < ActiveRecord::Base
  attr_accessible :arguments, :description, :example_request, :extensions, :goal, :method, :name, :path, :response_body, :responses_status, :title, :action
end
