namespace :themanual do

  namespace :import do

    desc "Import subscriptions from kickstarter"
    task kickstarter: :environment do

      people = SmarterCSV.process(ENV['CSV_PATH'], {
        key_mapping: {
          :'email_(for_login)' => :survey_email
        }
      })

      print people.to_yaml

      people.each do |p|

        if p[:survey_email].blank?
          print "Skipping backer #{p[:backer_name]}, no survey response yet\n"
          next
        end

        if User.where(email: p[:survey_email]).any?
          # user existss, skip
          print "User with email #{p[:survey_email]} exists, skipping\n"
        else
          user_attrs = {
            email: p[:survey_email],
            first_name: p[:first_name],
            last_name: p[:last_name]
          }

          print "Creating user for #{user_attrs[:email]}\n"

          user = User.create user_attrs




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



          # create subscription
          sub_attrs = {
            start_date: Date.parse(p[:pledged_at].split(',').first),
            start_issue: 4,
            issues_duration: 3,
            issues_remaining: 3,
            level: ENV['SUB_LEVEL']
          }

          subscription = user.subscriptions.create sub_attrs

          # give ownership of issue 4 to this subscription
          subscription.add_issue Issue.find_by_number(4)

        end

      end



    end

    desc "Import legacy subscriptions"
    task legacy: :environment do

    end

  end


end

