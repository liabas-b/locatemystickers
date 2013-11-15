class StickersController < ApplicationController
	# Helpers
	include ApplicationHelper
	helper_method :sort_column, :sort_direction

	# Filters
	before_filter :column_names

	# GET /users/1/stickers
	# GET /users/1/stickers.json
	def index
		@user = User.find_by_id(params[:user_id])
		@title = @user.name
		@stickers = @user.stickers.search(params[:search], params[:column]).reorder(sort_column + " " + sort_direction)
		@stickers = @stickers.paginate(per_page: params[:per_page] || 10 , :page => params[:page]) unless params[:paginate] == 'false'
		@form_path = user_stickers_path(@user)

		respond_to do |format|
			format.html { render 'stickers/show_stickers' }
			format.js { render 'stickers/show_stickers' }
			format.json { render :json => @stickers }
		end
	end

	# GET users/1/get_stickers.json
	def get_stickers
		user = User.find_by_id(params[:user_id])
		stickers = user.stickers.search(params[:search], params[:column]).reorder(sort_column + " " + sort_direction)
		stickers = stickers.paginate(per_page: params[:per_page] || 10 , :page => params[:page]) unless params[:paginate] == 'false'

		respond_to do |format|
			format.json { render :json => stickers }
		end
	end

	# GET users/1/stickers/count.json
	def count
		user = User.find_by_id(params[:user_id])

		respond_to do |format|
			format.json { render :json => user.stickers.count }
		end
	end

	# GET /stickers
	# GET /stickers.json
	def all_stickers
		@user = current_user
		@title = "All"
		@form_path = stickers_path
		@stickers = Sticker.search(params[:search], params['column']).reorder(sort_column + " " + sort_direction)
		@stickers = @stickers.paginate(per_page: params[:per_page] || 10 , page: params[:page]) unless params[:paginate] == 'false'

		respond_to do |format|
			format.html { render 'stickers/show_stickers' }
			format.js { render 'stickers/show_stickers' }
			format.json { render :json => @stickers }
		end
	end

	# GET /users/1/stickers/1
	# GET /users/1/stickers/1.json
	def show
		@sticker = Sticker.find(params[:id])
		@user = User.find_by_id(@sticker.user_id)
		@form_path = user_stickers_path(@user)

		respond_to do |format|
			format.html { gmaps_sticker_way }
			format.json { render :json => @sticker }
			format.js
		end
	end

	# GET /users/1/stickers/new
	# GET /users/1/stickers/new.json
	def new
		@user = User.find(params[:user_id])
		@sticker = Sticker.new
		@sticker.user_id = @user.id
		@sticker.sticker_type_id = params[:sticker_type_id]

		respond_to do |format|
			format.html # new.html.erb
			format.json { render :json => @sticker }
		end
	end

	# GET /users/1/stickers/1/edit
	def edit
		@sticker = Sticker.find(params[:id])
		@sticker.tags.build
		@user = User.find_by_id(@sticker.user_id)
	end

	# POST /users/1/stickers
	# POST /users/1/stickers.json
	def create
		@sticker = Sticker.new(params[:sticker])
		@sticker.user_id = params[:user_id]
		
		respond_to do |format|
			if @sticker.save
				generate_sticker_code
				format.html { redirect_to user_sticker_path(@sticker.user_id, @sticker), :notice => 'Sticker was successfully created.' }
				format.json { render :json => @sticker, :status => :created }
			else
				format.html { render :action => "new" }
				format.json { render :json => @sticker.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /users/1/stickers/1
	# PUT /users/1/stickers/1.json
	def update
		@sticker = Sticker.find(params[:id])
		@user = User.find_by_id(@sticker.user_id)

		respond_to do |format|
			if @sticker.update_attributes(params[:sticker])
				format.html { redirect_to user_sticker_path(@sticker.user_id, @sticker.id) }
				format.json { render :json => @sticker, :status => :updated }
			else
				format.html { redirect_to user_sticker_path(@sticker.user_id, @sticker.id) }
				format.json { render :json => @sticker.errors, :status => :unprocessable_entity }
			end
			format.js
		end
	end

	# DELETE /users/1/stickers/1
	# DELETE /users/1/stickers/1.json
	def destroy
		@sticker = Sticker.find(params[:id])
		if (@sticker != nil)
			@sticker.destroy
			respond_to do |format|
				format.html { redirect_to user_stickers_url(params[:user_id]) }
				format.json { render :json => true }
			end
		else
			render :json => false
		end
	end

	def minimap
		@sticker = Sticker.find(params[:sticker_id])
		@user = User.find_by_id(@sticker.user_id)
		gmaps_sticker_way
	end

	def last_location_address
		sticker = Sticker.find(params[:id])
		sticker.update_last_location
		render :json =>  sticker.last_location, status: :ok
	end

	def last_location
		sticker = Sticker.find(params[:id])
		sticker.update_last_location
		render :json =>  sticker.locations.last, status: :ok
	end

	def share_with_user
		@sticker = Sticker.find(params[:id])
		@sticker.share_with(User.find(params[:with_user_id]))
		render :json => true, status: :ok
	end

	def update_locations
		@sticker = Sticker.find(params[:id])
		# TODO
		@new_locations = @sticker.delay(run_at: Time.now, queue: 'locations').update_locations
		respond_to do |format|
			format.js
			format.json { render :json => @new_locations, status: :ok }
		end
	end

	def locations_for
		params[:id] = 190
		params[:from_date] = Time.now - 3.days
		params[:to_date] = Time.now
		params[:n] = 10
		params[:count_per_gap] = nil
		params[:time_gap] = nil
		locations = Sticker.find(params[:id])
							.locations.between_two_dates(params[:from_date], params[:to_date])
		total = locations.length
		n = params[:n]
		gap = total / n.round
		results = Array.new
		i = 0
		locations.each do |location|
			results.push(location) if i % gap == 0
			i += 1
		end
		render :json => {
			count: locations.count,
			after_filter_count: results.count,
			locations: results
		}, status: :ok
	end

	def locations
		params[:from_date] = Time.now - 3000.days
		params[:to_date] = Time.now
		params[:count_per_gap] = 1
		params[:time_gap] = 60*24*7 # 1 week in minuts

		user = User.find(params[:user_id])
		locations = Location.for_stickers(user.stickers).between_two_dates(params[:from_date], params[:to_date])

		results = Hash.new
		total = locations.length
		n = params[:n].to_i
		n = 100 if n == 0
		i = 0
		locations.each do |location|
			results[location.sticker_id] = Array.new if results[location.sticker_id].nil?

			gap = Location.where('sticker_id = ' + location.sticker.id.to_s).count / n.round
			gap = 1 if gap == 0
			results[location.sticker_id].push(location) if results[location.sticker_id].count < n && i % gap == 0

			i += 1
		end

		render :json => results, status: :ok
	end

	private

		def column_names
			@column_names = Sticker.column_names
		end

		def generate_sticker_code
		end

		def correct_user
			redirect_to root_url unless current_user.admin? || current_user?(User.find(params[:user_id]))
		end

		def correct_sticker_user
			@sticker = current_user.stickers.find_by_id(params[:id])
			redirect_to root_url unless current_user.admin? || !@sticker.nil?
		end

		def admin_user
			redirect_to root_url unless current_user.admin? 
		end

		def gmaps_sticker_way
			if @sticker.locations && @sticker.locations.any?
				gmaps_sticker_polylines
				gmaps_sticker_markers
			end
		end

		def gmaps_sticker_markers
			# @markers_json = @sticker.locations.to_gmaps4rails
		end

		def gmaps_sticker_polylines
			polylines_array = Array.new()
			one_polyline = Array.new()
			
			@sticker.locations.each do |location|
				one_polyline << {
					'ng' => location.longitude,
					'lat' => location.latitude
				}
			end

			polylines_array = [one_polyline]
			@polylines_json = polylines_array.to_json
		end

		# Not used, but works well.
		# Note: Put a div with id="instructions" to display the indications.
		def gmaps_sticker_direction
			waypoints = Array.new()
			@sticker.locations.each do |location|
				waypoints << location.latitude.to_s + "," + location.longitude.to_s
			end
			@direction = {
				"data"    => { "from" => waypoints.first, "to" => waypoints.last }, 
				"options" => { "waypoints" => waypoints, "display_panel" => true, "panel_id" => "instructions" }
			}
		end

		def sort_column
			Sticker.column_names.include?(params[:sort]) ? params[:sort] : "name"
		end
		
		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
		end

		def declare_sticker
			if defined?(params[:sticker_id])
			end
		end
end
