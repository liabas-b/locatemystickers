class StaticPagesController < ApplicationController
  include ApplicationHelper

  def home
	redirect_to user_path(current_user.id) if signed_in?
  end

  def help
  end

  def about
    @admins = User.where(admin: true)
  end

  def admin
    @admins = User.where(admin: true)
  end

  def contact
    @message = Message.new
  end

  def documentation
    respond_to do |format|
      format.html { redirect_to '/doc/apidoc.html' }
    end
  end
end
