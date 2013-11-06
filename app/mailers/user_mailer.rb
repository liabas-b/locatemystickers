class UserMailer < ActionMailer::Base
  default from: 'notifications@locatemystickers.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://locatemystickers.herokuapp.comm/sign_in'
    mail(to: @user.email, subject: "Welcome #{@user.name}")
  end

  def updated_sticker_locations sticker
    @sticker = sticker
    mail(to: @sticker.user.email, subject: "Your sticker #{@sticker.name} now has #{@sticker.locations.count} locations.")
  end
end
