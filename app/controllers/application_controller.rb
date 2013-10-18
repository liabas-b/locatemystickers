class ApplicationController < ActionController::Base
	
	protect_from_forgery
	include SessionsHelper
	include HistoriesHelper

	before_filter :get_user_notifications

	def is_number?(object)
		true if Float(object) rescue false
	end
end
