class ApplicationController < ActionController::Base
	
	protect_from_forgery
	include SessionsHelper
	include HistoriesHelper

	before_filter :get_user_notifications,:access_control_header

	def is_number?(object)
		true if Float(object) rescue false
	end

	def access_control_header
		headers['Access-Control-Allow-Origin'] = '*'
		headers['Access-Control-Allow-Headers'] = '*'
	end
end
