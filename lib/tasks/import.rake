namespace :themanual do

  namespace :import do

    desc "Import subscriptions from kickstarter"
    task kickstarter: :environment do

      people = SmarterCSV.process(ENV['CSV_PATH'], {
        key_mapping: {
          :'email_(for_login)' => :survey_email
        }
      })

      # print people.to_yaml

      people.each do |p|

        if p[:survey_email].blank?
          print "Skipping backer #{p[:backer_name]}, no survey response yet\n"
          next
        end

        user = User.find_by_email(p[:survey_email])

        unless user.present?

          user_attrs = {
            email: p[:survey_email],
            first_name: p[:first_name],
            last_name: p[:last_name]
          }

          print "Creating user for #{user_attrs[:email]}\n"

          user = User.create user_attrs

        end

        # skip is already imported this backer
        if user.backer_id.present?
          print "Already imported #{user.email}, skipping\n"
          next
        end

        user.update_attribute :backer_id, p[:backer_id]

        # save their address if needed
        if p[:shipping_country_code]

          address_attrs = {
            lines: [   p[:shipping_address_1], p[:shipping_address_2] ].compact.join("\n"),
            city: p[:shipping_city],
            region: p[:shipping_state],
            post_code: p[:shipping_postal_code],
            country_id: Shoppe::Country.find_by_code2(p[:shipping_country_code]).id
          }

          a = user.addresses.create address_attrs

          user.update_attribute :shipping_address_id, a.id

        end

        issue_start = 4

        # look for existing subscription
        if user.subscriptions.any?
          # start new sub after end of existing sub
          issue_start = 3 + user.subscriptions.collect(&:start_issue).max
        end


        # create subscription
        sub_attrs = {
          start_date: Date.parse(p[:pledged_at].split(',').first),
          start_issue: issue_start,
          issues_duration: 3,
          issues_remaining: 3,
          level: ENV['SUB_LEVEL']
        }

        subscription = user.subscriptions.create sub_attrs

        if subscription.start_issue == 4
          # give ownership of issue 4 to this subscription
          subscription.add_issue Issue.find_by_number(4)
        end


      end



    end

    desc "Import legacy subscriptions"
    task legacy: :environment do

      require 'open-uri'

      people = SmarterCSV.process open(ENV['CSV_PATH'])

      people.each do |p|

        if User.where(email: p[:email]).any?
          # user existss, load
          user = User.find_by_email p[:email]
        else
          user_attrs = {
            email: p[:email],
            first_name: p[:first_name],
            last_name: p[:last_name]
          }

          user = User.create user_attrs

        end

        print "."

        begin

          address_attrs = {
            lines: [ p[:shipping_company], p[:shipping_address_1], p[:shipping_address_2] ].compact.join("\n"),
            city: p[:shipping_town],
            region: p[:shipping_county],
            post_code: p[:shipping_postcode],
            country_id: Shoppe::Country.find_by_code2(p[:shipping_country]).try(:id)
          }

          a = user.addresses.create address_attrs

          user.update_attribute :shipping_address_id, a.id

        rescue
          print "\nFailed to create address for #{user.email}\n"
        end


        # create subscription
        sub_attrs = {
          start_date: Date.parse(p[:order_at]),
          start_issue: p[:subscription_start_issue],
          issues_duration: 3,
          issues_remaining: p[:issues_unshipped],
          level: 'print'
        }

        subscription = user.subscriptions.create sub_attrs

        # give ownership of issue 4 to this subscription
        (p[:subscription_start_issue]..4).each do |n|
          subscription.add_issue Issue.find_by_number(n)
        end


      end

    end

  end


end

