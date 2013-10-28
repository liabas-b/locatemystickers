class Notifier do
  def new_user user
    UserMailer.welcome_email(user).deliver
  end

end
