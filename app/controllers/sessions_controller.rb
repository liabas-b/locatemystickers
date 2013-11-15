class SessionsController < ApplicationController
  include ApplicationHelper

  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)

    if user && user.authenticate(params[:session][:password])
      sign_in user
      flash[:success] = "Hello, " + user.name + " :)"
    else
    end
    respond_to do |format|
      format.html { redirect_to root_url }
      format.js
      format.json { render :json => user, status: :ok }
    end
  end

  def destroy
    sign_out
    flash[:success] = "Successfuly logged out"
    redirect_to root_url
  end
  
end
