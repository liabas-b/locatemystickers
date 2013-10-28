class UserMailer < ActionMailer::Base
  default from: 'notifications@locatemystickers.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://locatemystickers.herokuapp.comm/sign_in'
    mail(to: @user.email, subject: 'Welcome to Locate My Stickers')
  end

  def update_sticker_locations sticker
    sticker.update_locations
    mail(to: sticker.user.email, subject: '[Locate My Stickers] sticker #{sticker.name} now has #[sticker.locations.count} locations.')
  end
end
