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
		send_message :new_location, Location.last
		# system("pwd >> launch_simulation");
		#system("ruby simulate_stickers.rb");
		respond_to do |format|
			format.js
		end
	end

	def routes

		if params[:update] == 'true'
			file_routes = Array.new
			puts 'bundle exec rake routes > routes'
			system 'bundle exec rake routes > routes'
			File.open("routes", "r") {|io| io.read}.split(/\r?\n/).each { |l| file_routes << l.split(' ') };

			AppRoute.destroy_all

			file_routes.each do |route|
				name = 'Default name'
				method = 'Default method'
				path = 'Default path'
				action = 'Default action'
				route.each do |r|
					if r.include?('#')
						action = r
					elsif r.include?('_')
						name = r
					elsif r.include?('/')
						path = r
					elsif r.include?('GET')
						method = r
					end
				end
				AppRoute.create!({
					title: 'Title ' + AppRoute.count.to_s,
					name: name,
					path: path,
					method: method,
					action: action
				})
			end
		end

		@routes = AppRoute.all
	end

	def update_route
		route = AppRoute.find(params[:id])
		route.update_attributes(params[:app_route])
		
		respond_to do |format|
			format.js
		end
	end

	def web_sockets
	end
end
