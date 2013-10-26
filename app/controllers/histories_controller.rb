class HistoriesController < ApplicationController
  include ApplicationHelper
  before_filter :column_names
  helper_method :sort_column, :sort_direction
  
  # GET /histories
  # GET /histories.json
  def index
    @user = current_user
    if (params.has_key?(:user_id) && !params[:user_id].nil?)
      @histories = History.where("user_id="+ params[:user_id])
      if (params.has_key?(:sticker_id) && !params[:sticker_id].nil?)
        @histories += @histories.where("sticker_id="+ params[:sticker_id])
        if (params.has_key?(:location_id) && !params[:location_id].nil?)
          @histories += @histories.where("location_id="+ params[:location_id])
        end
      end
      @form_path = user_histories_path(User.find(params[:user_id]))
    else
      @histories = History.search(params[:search], params["column"]).reorder(sort_column + " " + sort_direction).paginate(:page => params[:page])
      @form_path = histories_path
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json { render json: @histories }
    end
  end

  # GET /histories/1
  # GET /histories/1.json
  def show
    @history = History.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/new
  # GET /histories/new.json
  def new
    @history = History.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @history }
    end
  end

  # GET /histories/1/edit
  def edit
    @history = History.find(params[:id])
  end

  # POST /histories
  # POST /histories.json
  def create
    @history = History.new(params[:history])

    respond_to do |format|
      if @history.save
        format.html { redirect_to @history, notice: 'History was successfully created.' }
        format.json { render json: @history, status: :created }
      else
        format.html { render action: "new" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /histories/1
  # PUT /histories/1.json
  def update
    @history = History.find(params[:id])

    respond_to do |format|
      if @history.update_attributes(params[:history])
        format.html { redirect_to @history, notice: 'History was successfully updated.' }
        format.json { render json: @history, status: :ok }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /histories/1
  # DELETE /histories/1.json
  def destroy
    @history = History.find(params[:id])

    respond_to do |format|
      if @history
        @history.destroy
        format.html { redirect_to histories_url }
        format.json { render nothing: true, status: :ok }
      else
        format.html { redirect_to histories_url }
        format.json { render nothing: true, status: :not_found }
      end
    end
  end

  # ATTENTION
  def confirm
    @history = History.find(params[:id])

    respond_to do |format|
      if @history.update_attributes(:notification_confirmed => 1)
        format.html { redirect_to histories_url }
        format.json { render nothing: true, status: :ok }
      else
        format.html { redirect_to histories_url }
        format.json { render nothing: true, status: :not_found }
      end
    end
  end

  private

    def column_names
      @column_names = History.column_names
    end

    def sort_column
      History.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
    end
end
