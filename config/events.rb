WebsocketRails::EventMap.describe do
  # subscribe :client_connected, :to => WebSocketsController, :with_method => :method_name
  subscribe :new_location, :to => LiveLocationsController, :with_method => :new_location
end
