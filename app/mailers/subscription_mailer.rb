class SubscriptionMailer < TheManual::Mailer

  def shipping_address_update to, data
    @data = data
    to = "hi@themanual.org" if ENV['MODE'] == "TEST"
    mail to: to, subject: "Update your subscription address for Issue #{@data[:issue_number]}"
  end

  def new_issue_digital_editions to, data
    @data = data
    to = "hi@themanual.org" if ENV['MODE'] == "TEST"
    mail to: to, subject: "Your digital editions of Issue #{@data[:issue_number]} are now available!"
  end

  def new_issue_web_edition to, data
    @data = data
    to = "hi@themanual.org" if ENV['MODE'] == "TEST"
    mail to: to, subject: "Your web edition of Issue #{@data[:issue_number]} is now available!"
  end

end
