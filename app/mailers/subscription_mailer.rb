class SubscriptionMailer < TheManual::Mailer

  def shipping_address_update to, data
    @data = data
    to = "hi@themanual.org" if ENV['MODE'] == "TEST"
    mail to: to, subject: "Issue #{@data[:issue_number]} is ready to ship: Update your address!"
  end

end
