class SubscriptionMailer < TheManual::Mailer

  def shipping_address_update to, data
    @data = data
    to = "hi@themanual.org" if ENV['MODE'] == "TEST"
    mail to: to, subject: "Update your subscription address for issue #{@data[:issue_number]}"
  end

end
