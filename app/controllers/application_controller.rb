class ApplicationController < ActionController::Base
	before_filter :get_user_notifications
	
  protect_from_forgery
  include SessionsHelper

  def is_number?(object)
    true if Float(object) rescue false
  end
end
