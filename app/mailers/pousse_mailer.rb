class PousseMailer < Pousse::Mailer
  def send_alert
    mail(
      to: 'everybody',
      body: 'alert("Hello World !");'
    )
  end
end
