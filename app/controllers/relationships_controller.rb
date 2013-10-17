class RelationshipsController < ApplicationController
  #before_filter :login_or_oauth_required

  def create
    @user = User.find(params[:relationship][:owner_id])
    @sticker = Sticker.find(params[:relationship][:sticker_id])
    current_user.follow!(params[:relationship][:owner_id], @sticker.id)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @sticker = Relationship.find(params[:id]).sticker
    current_user.unfollow!(@sticker)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
