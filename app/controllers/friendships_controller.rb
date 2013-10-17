class FriendshipsController < ApplicationController
  include ApplicationHelper
  #before_filter :signed_in_user

  def create
    @user = User.find(params[:friendship][:followed_id])
    current_user.add_friend!(@user)

    respond_to do |format|
      format.html { redirect_to user_path(params[:friendship][:followed_id]) }
      format.js
    end
  end

  def destroy
    @user = Friendship.find(params[:id]).followed
    current_user.remove_friend!(@user)
    
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
