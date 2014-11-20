namespace :themanual do

  namespace :mailer do

    desc 'Send address update email to subscribers'
    task :shipping_address_update => :environment do

      unless ENV['ISSUE'].present? && ENV['MODE'].present? && (ENV['MODE'] == "TEST" || ENV['MODE'] == "SEND")
        abort "Required: ISSUE [N] and MODE [TEST|SEND] environment variables."
      end

      issue_number = ENV['ISSUE'].to_i
      subscriptions = Subscription.active.has_shipping.with_issue(issue_number).includes(user: [:shipping_address])

      # kickstarter backers only this time
      subscriptions = subscriptions.joins(:user).where('users.backer_id IS NOT NULL')

      # if mode is test, get a random person
      subscriptions  = [subscriptions.sample] if ENV['MODE'] == 'TEST'


      # send emails
      puts "Going to send emails to #{subscriptions.length} subscribers."
      subscriptions.each do |subscription|

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

    desc 'New issue in DIGITAL editions available to ebook, audiobook, print, and full subscribers'
    task :new_issue_digital_editions => :environment do

      unless ENV['ISSUE'].present? && ENV['MODE'].present? && (ENV['MODE'] == "TEST" || ENV['MODE'] == "SEND")
        abort "Required: ISSUE [N] and MODE [TEST|SEND] environment variables."
      end

      issue_number  = ENV['ISSUE'].to_i
      subscriptions = Subscription.active.with_issue(issue_number).has_downloads
      # non-backers only TODO remove for issue 5
      subscriptions = subscriptions.joins(:user).where('users.backer_id IS NULL')
      # if mode is test, get a random person
      subscriptions = [subscriptions.sample] if ENV['MODE'] == 'TEST'

      # send emails
      puts "Going to send emails to #{subscriptions.length} subscribers."
      subscriptions.each do |subscription|
        data = {
          user: subscription.user,
          subscription: subscription,
          issue_number: issue_number
        }
        print "Sending email to #{subscription.user.full_name} <#{subscription.user.email}>... " and STDOUT.flush
        SubscriptionMailer.new_issue_digital_editions(subscription.user.email, data).deliver
        puts "sent!"
      end
    end

    desc 'New issue in WEB editon available to web-only subscribers'
    task :new_issue_web_edition => :environment do

      unless ENV['ISSUE'].present? && ENV['MODE'].present? && (ENV['MODE'] == "TEST" || ENV['MODE'] == "SEND")
        abort "Required: ISSUE [N] and MODE [TEST|SEND] environment variables."
      end

      issue_number  = ENV['ISSUE'].to_i
      subscriptions = Subscription.active.with_issue(issue_number).where(level: "web")
      # non-backers only TODO remove for issue 5
      subscriptions = subscriptions.joins(:user).where('users.backer_id IS NULL')
      # if mode is test, get a random person
      subscriptions = [subscriptions.sample] if ENV['MODE'] == 'TEST'

      # send emails
      puts "Going to send emails to #{subscriptions.length} subscribers."
      subscriptions.each do |subscription|
        data = {
          user: subscription.user,
          subscription: subscription,
          issue_number: issue_number
        }
        print "Sending email to #{subscription.user.full_name} <#{subscription.user.email}>... " and STDOUT.flush
        SubscriptionMailer.new_issue_web_edition(subscription.user.email, data).deliver
        puts "sent!"
      end
    end

  end



end
