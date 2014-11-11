namespace :themanual do

  namespace :mailer do

    desc 'Send address update email to subscribers'
    task :shipping_address_update => :environment do

      unless ENV['ISSUE'].present? && ENV['MODE'].present? && (ENV['MODE'] == "TEST" || ENV['MODE'] == "SEND")
        abort "Required: ISSUE [N] and MODE [TEST|SEND] environment variables."
      end

      issue_number = ENV['ISSUE'].to_i
      subscriptions = Subscription.active.has_shipping.with_issue(issue_number).includes(user: [:shipping_address])

      # if mode is test, get a random person
      subscriptions  = [subscriptions.sample] if ENV['MODE'] == 'TEST'

      # FUDGE FOR FAILED RUN, DELETE WHEN COMPLETE
      actually_send = false


      # send emails
      subscriptions.each do |subscription|

        # FUDGE PART DEUX
        if subscription.user_id == 68
          actually_send = true
          next
        else
          next if !actually_send
        end




        data = {
          user: subscription.user,
          subscription: subscription,
          issue_number: issue_number
        }
        print "Sending email to #{subscription.user.full_name} <#{subscription.user.email}>... " and STDOUT.flush
        SubscriptionMailer.shipping_address_update(subscription.user.email, data).deliver
        puts "sent!"
      end
    end

  end

end
