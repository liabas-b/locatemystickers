class AdministrationController < ApplicationController
	include ApplicationHelper

	def admin
	end

	def developer_guide
	end

	def simulator
		@sticker = get_ws_user_stickers(current_user.id).first
		@simulation = Simulation.create!(user_id: current_user.id, sticker_id: @sticker.id, locations_sent: 0, description: "#{current_user.name}: Simulation " + Simulation.count.to_s)
	end

	def launch_simulation
		system("pwd >> launch_simulation");
		#system("ruby simulate_stickers.rb");
	    respond_to do |format|
	      format.js
	    end
	end

	def routes
		@routes = Array.new
		puts 'bundle exec rake routes > routes'
		system 'bundle exec rake routes > routes'
		File.open("routes", "r") {|io| io.read}.split(/\r?\n/).each { |l| @routes << l.split(' ') };
	end

	def web_sockets
	end
end
