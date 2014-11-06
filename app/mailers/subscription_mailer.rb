class SubscriptionMailer < TheManual::Mailer

  def shipping_address_update to, data
    @data = options[:data]
    mail to: options[:to], subject: "Issue #{@data[:issue_number]} is ready to ship: Update your address!"
  end

end
