# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
LocateMyStickers::Application.initialize!

Rails.configuration.app_scope = "webapp" #"service"
Rails.configuration.debug_active = true
puts "Running on " + Rails.configuration.app_scope + "..."
