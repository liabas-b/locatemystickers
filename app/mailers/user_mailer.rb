class UserMailer < ActionMailer::Base
  default from: 'notifications@locatemystickers.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://locatemystickers.herokuapp.comm/sign_in'
    mail(to: @user.email, subject: 'Welcome to Locate My Stickers')
  end
end
