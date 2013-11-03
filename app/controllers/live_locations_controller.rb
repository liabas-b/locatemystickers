class LiveLocationsController < WebsocketRails::BaseController
  before_filter :ensure_logged_in!
  before_filter do
    puts "an event handled by LiveLocationsController was called"
  end
  after_filter do
    puts "perform post-action work"
  end
  around_filter :time_request

  def ensure_logged_in!
    if current_user.nil?
      current_user = User.new
    end
  end

  def time_request
    start = Time.now
    yield
    delta = Time.now - start
    puts "Action took #{delta.to_f} seconds"
  end


  def initialize_session
    controller_store[:message_count] = 0
  end

  def new_location
    send_message :event_name, Location.last
  end
end
