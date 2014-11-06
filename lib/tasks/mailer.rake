namespace :themanual do
  
  namespace :mailer do

    desc 'Send address update email to subscribers'
    task :shipping_address_update => :environment do |t, args|
      
      raise StandardError("Required: ISSUE and MODE environment variables.") unless ENV['ISSUE'].present? && ENV['MODE'].present?

      issue_number = ENV['ISSUE']
      subscriptions = Subscription.active.has_shipping.with_issue(issue_number).includes(user: [:shipping_address])

      # if mode is test, get a random person
      subscriptions  = [subscriptions.sample] if ENV['MODE'] == 'TEST'

      subscriptions.each do |subscription| 
        SubscriptionMailer.shipping_address_update({
          to: subscription.user.email,
          data: {
            user: subscription.user, 
            subscription: subscription,
            issue_number: issue_number
          }
        }).deliver
      end
    end

  end

end
