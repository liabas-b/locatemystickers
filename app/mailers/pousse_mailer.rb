class PousseMailer < Pousse::Mailer
  def send_alert
    mail(
      to: 'everybody',
      body: 'alert("Hello World !");'
    )
  end

  def do_test
    mail(
      to: 'everybody',
      body: "alert('hello'); create_marker(0, 0, 'test');"
      # body: "$('span#" + location.sticker.id.to_s + ".sticker_locations_count').html('" + location.sticker.locations.count.to_s + "');"
    )
  end

  def new_location location
    puts location.inspect
    mail(
      to: 'everybody',
      body: "live_location(" + location.latitude.to_s + ", " + location.longitude.to_s + ", '" + location.sticker.name + "');"
      )
  end
end
