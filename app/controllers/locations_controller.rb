class LocationsController < ApplicationController
  include ApplicationHelper

  helper_method :sort_column, :sort_direction
  before_filter :column_names
  #before_filter :login_or_oauth_required
  #before_filter :correct_user
  #skip_before_filter :correct_user, only: [:all_locations]
  #before_filter :admin_user, only: [:destroy, :update, :edit, :new, :create, :all_locations]

  # GET /users/1/stickers/1/locations
  # GET /users/1/stickers/1/locations.json
  def index
    @user = User.find(params[:user_id])
    @sticker = Sticker.find(params[:sticker_id])
    @locations = @sticker.locations.search(params[:search], params[:column]).reorder(sort_column + " " + sort_direction)
    @locations = @locations.paginate(per_page: params[:per_page] || 10 , :page => params[:page]) unless params[:paginate] == 'false'

    respond_to do |format|
      format.html { gmaps_all_locations_markers } # index.html.erb
      format.json { render json: @locations }
      format.js
    end
  end

  def count
    @sticker = Sticker.find(params[:sticker_id])
    render :json => @sticker.locations.count
  end

  # GET /locations
  # GET /locations.json
  def all_locations
    @locations = Location.search(params[:search], params[:column]).reorder(sort_column + " " + sort_direction).paginate(per_page: 10, :page => params[:page])

    respond_to do |format|
      format.html { gmaps_all_locations_markers }
      format.js
      format.json { render json: @locations }
    end
  end

  # GET /users/1/stickers/1/locations/1
  # GET /users/1/stickers/1/locations/1.json
  def show
    @user = User.find(params[:user_id])
    @sticker = Sticker.find(params[:sticker_id])
    @location = Location.find(params[:id])

    respond_to do |format|
      format.html { gmaps_location_marker }
      format.json { render json: @location }
    end
  end

  # GET /users/1/stickers/1/locations/new
  # GET /users/1/stickers/1/locations/new.json
  def new
    @user = User.find(params[:user_id])
    @location = Location.new
    @location.is_new = true
    @sticker = Sticker.find(params[:sticker_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  # GET /users/1/stickers/1/locations/1/edit
  def edit
    @location = Location.find(params[:id])
    @sticker = @location.sticker
    @user = @sticker.user

    respond_to do |format|
      format.html { gmaps_location_marker }
      format.js
    end
  end

  # POST /users/1/stickers/1/locations
  # POST /users/1/stickers/1/locations.json
  def create
    @location = Location.new(params[:location])
    @location.sticker_id = params[:sticker_id]
    @sticker = Sticker.find_by_id(@location.sticker_id)
    @user = User.find_by_id(@sticker.user_id)

    respond_to do |format|
      if @location.save
        format.html { redirect_to user_sticker_locations_path(@user, @sticker), notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1/stickers/1/locations/1
  # PUT /users/1/stickers/1/locations/1.json
  def update
    @location = Location.find(params[:id])
    @sticker = Sticker.find_by_id(@location.sticker_id)
    @user = User.find_by_id(@sticker.user_id)

    flash[:notice] = "Location " + @location.id.to_s + " updated"

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to user_sticker_location_path(@user, @sticker, @location), notice: 'Location was successfully updated.' }
        format.js
        format.json { render :json => @location, :status => :updated }
      else
        format.html { render action: "edit" }
        format.js
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/stickers/1/locations/1
  # DELETE /users/1/stickers/1/locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @sticker = Sticker.find_by_id(@location.sticker_id)
    @user = User.find_by_id(@sticker.user_id)
    @location.destroy

    respond_to do |format|
      format.html { redirect_to user_sticker_locations_path(@user, @sticker) }
      format.json { render :json => true }
    end
  end

  def live_locations
    @last_locations = Array.new
    User.first.stickers.each do |sticker|
      sticker.update_last_location
      puts sticker.locations.first
      location = sticker.locations.first
      unless location.nil?
        @last_locations.push({location: location, color: sticker.color})
      end
    end
    render :json => @last_locations
  end

  private

    def column_names
      @column_names = Location.column_names
    end

    def sort_column
      Location.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def gmaps_all_locations_markers
      # @markers_json = @locations.to_gmaps4rails do |location, marker|
      #   sticker = location.sticker_id
      #   unless sticker.nil?
      #     marker.infowindow render_to_string(:partial => "/locations/maps_info_window",
      #                                        :locals => { :location => location, :sticker => sticker })
      #     marker.title   location.created_at.to_datetime
      #     marker.json({ :id => location.id })
      #   end
      # end
    end

    def gmaps_location_marker
      # @markers_json = @location.to_gmaps4rails do |location, marker|
      #   sticker = location.sticker_id
      #   unless sticker.nil?
      #     marker.infowindow render_to_string(:partial => "/locations/maps_info_window",
      #                                        :locals => { :location => location, :sticker => sticker })
      #     marker.title   location.created_at.to_datetime
      #     marker.json({ :id => location.id })
      #   end
      # end
    end

    def correct_user
      redirect_to root_url unless current_user?(User.find(params[:user_id])) || current_user.admin?
    end

    def admin_user
      redirect_to root_url unless current_user.admin? 
    end
end
