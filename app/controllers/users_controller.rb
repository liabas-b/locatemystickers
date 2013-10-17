class UsersController < ApplicationController
  include ApplicationHelper

  before_filter :column_names, only: [:index]
  before_filter :stickers_column_names, only: [:show, :stickers]
  helper_method :sort_column, :sort_direction
  # before_filter :correct_user,  only: [:edit, :update, :show]
  # before_filter :admin_user,    only: [:destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.search(params[:search], params["column"]).reorder(sort_column + " " + sort_direction).paginate(per_page: 10, :page => params[:page])
    @form_path = users_path

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @stickers = @user.stickers.search(params[:search], params["column"]).reorder(stickers_sort_column + " " + stickers_sort_direction).paginate(per_page: 10, :page => params[:page])
    @followed_stickers = @user.followed_stickers.search(params[:search], params["column"]).reorder(stickers_sort_column + " " + stickers_sort_direction).paginate(per_page: 10, :page => params[:page])
    @form_path = user_path(@user)
    @user.update_all_locations

    respond_to do |format|
      format.html {
        gmaps_last_locations_markers
      }
      format.js # show.js.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @user.compteur = 1

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    if @user.save
      sign_in @user unless signed_in?
      flash[:success] = "Welcome " + @user.name + "!"
      redirect_to user_path(@user.id)
    else
      render 'new'
      # ATTENTION ADD ERRORS 
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
      # ATTENTION ADD ERRORS 
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render :json => true }
      format.js
    end
  end

  def count
    render :json => User.count
  end

  def stickers
    @user = User.find(params[:id])
    @title = @user.name + "'s"
    @stickers = @user.stickers.order(:id).paginate(:page => params[:page])

    respond_to do |format|
      format.html { render 'stickers/show_stickers' }
      format.json { render :json => @stickers }
    end
  end

  def friends
    @title = "Friends"
    @user = User.find(params[:id])
    @users = @user.followed_users#.search(params[:search], params["column"]).reorder(sort_column + " " + sort_direction).paginate(per_page: 10, :page => params[:page])

    respond_to do |format|
      format.html
      format.js
      format.json { render :json => @users }
    end
  end

  def followed_stickers
    @title = "Followed"
    @user = User.find(params[:id])
    @stickers = @user.followed_stickers.order(:name).paginate(:page => params[:page])

    respond_to do |format|
      format.html { render 'stickers/show_stickers' }
      format.json { render :json => @stickers }
    end
  end

  def shared_stickers
    @title = "Shared"
    @user = User.find(params[:id])
    @stickers = @user.shared_stickers.order(:name).paginate(:page => params[:page])

    respond_to do |format|
      format.html { render 'stickers/show_stickers' }
      format.json { render :json => @stickers }
    end
  end

  def updated_data
    @title = "Shared"
    @user = User.find(params[:id])
    @stickers = @user.stickers

    respond_to do |format|
      format.json {
        if (!params[:compteur].nil?)
          compteur = Integer(params[:compteur])
          if (compteur < @user.compteur)
            data = Array.new()
            @stickers.each do |sticker|
              data.push("users/" + @user.id.to_s + "/stickers/" + sticker.id.to_s)
              sticker.locations.each do |location|
                data.push("users/" + @user.id.to_s + "/stickers/" + sticker.id.to_s + "/locations/" + location.id.to_s)
              end
            end
            render :json => data
          else
            render :json => ""
          end
        else
          render :json => ""
        end
      }
    end
  end

  def statistics
    # ATTENTION TODO
    
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
    end
  end

  def empty_stickers_locations
    user = User.find(params[:id])
    user.stickers.each do |s|
      s.locations.each do |l|
        CLogger.debug l.inspect.to_s " DELETING"
        l.destroy
      end
    end
    render :json => 'completed'
  end

  private

    def column_names
      @column_names = User.column_names
    end
    def stickers_column_names
      @column_names = Sticker.column_names
    end

    def correct_user
      instanciate_user(params[:id])

      if !current_user?(@user) && !current_user.admin?
        redirect_to(root_path)
      end
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def stickers_sort_column
      Sticker.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
    
    def stickers_sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def followed_stickers_sort_column
      Sticker.column_names.include?(params[:followed_sort]) ? params[:followed_sort] : "name"
    end
    
    def followed_stickers_sort_direction
      %w[asc desc].include?(params[:followed_direction]) ? params[:followed_direction] : "asc"
    end

    def gmaps_last_locations_markers
      if @stickers.count > 0 || @followed_stickers.count > 0
        @last_locations = Array.new
        @stickers.each do |sticker|
          unless sticker.locations.empty?
            @last_locations.push(sticker.locations.last)
          end
        end
        unless @last_locations.nil?
          @markers_json = @last_locations.to_gmaps4rails do |location, marker|
            marker.infowindow render_to_string(:partial => "/locations/maps_info_window",
                                               :locals => { :location => location })
            
            marker.picture({
                            :picture => "http://www.blankdots.com/img/github-32x32.png",
                            :width   => 32,
                            :height  => 32
                           })
            marker.title   location.created_at.to_datetime
            marker.json({ :id => location.id })
            CLogger.debug marker.inspect
          end
        end
      end
    end
end
