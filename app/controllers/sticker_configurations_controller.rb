class StickerConfigurationsController < ApplicationController
  include ApplicationHelper
  
  before_filter :column_names, :get_user, :get_sticker
  helper_method :sort_column, :sort_direction

  # GET /sticker_configurations
  # GET /sticker_configurations.json
  def index
    @sticker_configurations = StickerConfiguration.search(params[:search], params["column"]).reorder(sort_column + " " + sort_direction)
    @sticker_configurations = @sticker_configurations.paginate(per_page: 10, :page => params[:page]) unless params[:paginate] == 'false'
    @column_names = StickerConfiguration.column_names

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sticker_configurations }
      format.js
    end
  end

  # GET /sticker_configurations/1
  # GET /sticker_configurations/1.json
  def show
    @sticker_configuration = StickerConfiguration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @sticker_configuration }
      format.pdf { generate_documentation([stickerconfiguration: [cle: 'valeur']]) }
    end
  end

  # GET /sticker_configurations/new
  # GET /sticker_configurations/new.json
  def new
    @sticker_configuration = StickerConfiguration.new
    @sticker_configuration.sticker_code = @sticker.code
    @sticker_configuration.activate = @sticker.is_active?
    @sticker_configuration.frequency_update = 12;

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @sticker_configuration }
    end
  end

  # GET /sticker_configurations/1/edit
  def edit
    @sticker_configuration = StickerConfiguration.find(params[:id])
  end

  # POST /sticker_configurations
  # POST /sticker_configurations.json
  def create
    @sticker_configuration = StickerConfiguration.new(params[:sticker_configuration])

    respond_to do |format|
      if @sticker_configuration.save
        format.html { redirect_to user_sticker_sticker_configuration_path(@user, @sticker, @sticker_configuration), notice: 'Sticker configuration was successfully created.' }
        format.json { render json: @sticker_configuration, status: :created, location: @sticker_configuration }
      else
        format.html { render action: "new" }
        format.json { render json: @sticker_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /sticker_configurations/1
  # PUT /sticker_configurations/1.json
  def update
    @sticker_configuration = StickerConfiguration.find(params[:id])

    respond_to do |format|
      if @sticker_configuration.update_attributes(params[:sticker_configuration])
        format.html { redirect_to user_sticker_sticker_configuration_path(@user, @sticker, @sticker_configuration), notice: 'Sticker configuration was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @sticker_configuration.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sticker_configurations/1
  # DELETE /sticker_configurations/1.json
  def destroy
    @sticker_configuration = StickerConfiguration.find(params[:id])
    @sticker_configuration.destroy

    respond_to do |format|
      format.html { redirect_to user_sticker_sticker_configurations_path(@user, @sticker) }
      format.json { head :no_content }
    end
  end

  private

    def sort_column
      StickerConfiguration.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end

    def column_names
      @column_names = StickerConfiguration.column_names
    end

    def get_user
      @user = User.find(params[:user_id])
    end

    def get_sticker
     @sticker = Sticker.find(params[:sticker_id])
    end
end
