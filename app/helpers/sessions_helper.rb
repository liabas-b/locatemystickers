module SessionsHelper
  include UsersHelper

  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    self.current_user = user
    CLogger.debug('Signed in : ' + (@current_user ? @current_user.name : "nil"))
  end

  def signed_in?
    !current_user.nil?
  end

  def logged_in?
    !current_user.nil?
  end
  
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    return @current_user
  end

  def current_user?(user)
    return user == current_user
    CLogger.debug "current_user? " + (user == @current_user).to_s + " (user: " + user.name + ", current_user: " + (current_user ? current_user.name : "nil") + ")"
  end

  def login_required
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

end
