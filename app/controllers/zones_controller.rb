require 'net/http'

class ZonesController < ApplicationController
  before_filter :column_names

  # GET /user/1/sticker/1/zones
  # GET /user/1/sticker/1/zones.json
  def index
    @zones = Zone.where('sticker_id = ' + params[:sticker_id])
    @user = User.find(params[:user_id])
    declare_sticker

    respond_to do |format|
      format.html { gmaps_all_zones_marker }
      format.json { render json: @zones }
    end
  end

  # GET /zones
  # GET /zones.json
  def all_zones
    @zones = Zone.all
    @user = current_user

    respond_to do |format|
      format.html # all_zones.html.erb
      format.json { render json: @zones }
    end
  end

  # GET /zones/1
  # GET /zones/1.json
  def show
    @user = User.find(params[:user_id])
    declare_sticker
    @zone = Zone.find(params[:id])

    respond_to do |format|
      format.html { gmaps_zone_marker } # show.html.erb
      format.json { render json: @zone }
    end
  end

  # GET /zones/new
  # GET /zones/new.json
  def new
    @user = User.find(params[:user_id])
    declare_sticker
    @zone = Zone.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @zone }
    end
  end

  # GET /zones/1/edit
  def edit
    @user = User.find(params[:user_id])
    declare_sticker
    @zone = Zone.find(params[:id])
  end

  # POST /zones
  # POST /zones.json
  def create
    @user = User.find(params[:user_id])
    declare_sticker
    @zone = Zone.new(params[:zone])
    @zone.sticker_id = @sticker.id


    respond_to do |format|
      if @zone.save
        format.html { redirect_to user_sticker_zone_path(@user, @sticker, @zone), notice: 'Zone was successfully created.' }
        format.json { render json: @zone, status: :created, location: @zone }
      else
        format.html { render action: "new" }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /zones/1
  # PUT /zones/1.json
  def update
    @zone = Zone.find(params[:id])

    respond_to do |format|
      if @zone.update_attributes(params[:zone])
        format.html { redirect_to @zone, notice: 'Zone was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @zone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zones/1
  # DELETE /zones/1.json
  def destroy
    @user = User.find(params[:user_id])
    declare_sticker
    @zone = Zone.find(params[:id])
    @zone.destroy

    respond_to do |format|
      format.html { redirect_to user_sticker_zones_url(@user, @sticker) }
      format.json { head :no_content }
    end
  end

  private

  def gmaps_zone_marker
    @polygons = []
    @one_polygon = []
    @zone.locations.each do |location|
      @one_polygon << { lng: location.longitude, lat: location.latitude,
        strokeColor: @zone.colour,
        strokeOpacity: 0.3,
        strokeWeight: 1,
        fillColor: @zone.colour,
        fillOpacity: 0.05
       }
    end
    @polygons << @one_polygon
    @polygons_json = @polygons.to_json
  end

  def gmaps_all_zones_marker
    @polygons = []
    @zones.each do |zone|
      i = 0
      @one_polygon = []
      zone.locations.each do |location|
        if i == 0
          @one_polygon << { lng: location.longitude, lat: location.latitude,
          strokeColor: zone.colour,
          strokeOpacity: 0.3,
          strokeWeight: 1,
          fillColor: zone.colour,
          fillOpacity: 0.05
         }
        else
          @one_polygon << { lng: location.longitude, lat: location.latitude}
        end
        @polygons << @one_polygon
        i = i + 1
      end
    end
    @polygons_json = @polygons.to_json
  end

  def declare_sticker
    if defined?(params[:sticker_id])
      @sticker = Sticker.where("code='" + params[:sticker_id] + "' OR id='" + params[:sticker_id] + "' AND user_id=" + params[:user_id]).first
    end
  end

  private

    def column_names
      @column_names = Zone.column_names
    end
end
