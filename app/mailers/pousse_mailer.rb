class PousseMailer < Pousse::Mailer
  def send_alert
    mail(
      to: 'everybody',
      body: 'alert("Hello World !");'
    )
  end

  def new_location location
    mail(
      to: 'everybody',
      body: "$('span#" + location.sticker.id.to_s + ".sticker_locations_count').html('" + location.sticker.locations.count.to_s + "');"
      )
  end
end
