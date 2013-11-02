class UserMailer < ActionMailer::Base
  default from: 'notifications@locatemystickers.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://locatemystickers.herokuapp.comm/sign_in'
    mail(to: @user.email, subject: "Welcome #{@user.name}")
  end

  def update_sticker_locations sticker
    @sticker = sticker
    @sticker.update_locations
    mail(to: @sticker.user.email, subject: "Your sticker #{@sticker.name} now has #{@sticker.locations.count} locations.")
  end
end
