namespace :themanual do

  desc "Estimate shipping for an issue"
  task :shipping_estimate => :environment do

    i = 0
    csv_string = CSV.generate do |csv|

      csv << ['Subscription ID', 'User ID', 'Name', 'Address', 'Shipping Currency', 'Shipping Cost', 'Ship from', 'Ship method', 'Error?']


      # Subscription.includes(:user => {:shipping_address => :country}).active.has_shipping.with_issue(ENV['ISSUE'].to_i).each do |sub|

      issue = Issue.find_by_number(ENV['ISSUE'].to_i)

      Ownership.joins(:user)
        .includes(:user)
        .where('subscription_id IS NOT NULL') # ownerships that came via subscriptions
        .where(issue_id: issue.id) # this issue
        .where(level: %w(print full)) # physical product
        .where(shipped: false) # not yet shipped
        .all
        .each do |ownership|

        sub = ownership.subscription

        next if sub.user.name.nil?

        if ENV['LIMIT']
          i = i + 1
          next if i > ENV['LIMIT'].to_i
        end

        address = sub.user.shipping_address

        data = [sub.id, sub.user.id, sub.user.name, sub.user.shipping_address.name.gsub("\n", ', ')]

        begin

          order = Shipwire::Order.new(nil)
          order.address = Shipwire::Address.new( {
                                                  name: address.user.name,
                                                  address1: (address.lines || ''),
                                                  city: address.city,
                                                  country: address.country.code2,
                                                  state: address.region,
                                                  zip: address.post_code
                                                }, false)

          order.add_item Shipwire::OrderItem.new("MNUISS00#{ENV['ISSUE']}", 1)

          rates = Shipwire::Api.new.rate(order)


          quotes = rates['resource']['rates']

          print quotes.to_yaml

          if quotes.nil?
            costs[sub.id] = {error: 'no rates available'}
          else

            rate = quotes.first['serviceOptions'].first

            shipment = rate['shipments'].first

            data += [
              shipment['cost']['currency'],
              shipment['cost']['amount'],
              shipment['warehouseName'],
              shipment['carrier']['description']
            ]

            csv << data
          end

        rescue Net::OpenTimeout, Shipwire::ApiTimeout
          data += ['', '', '', '', 'API timeout']
          csv << data
        rescue Interrupt => e
          raise e
        rescue Exception => e
          data += ['', '', '', '', e.message]
          csv << data
          raise e
        end

        STDERR.print '.'
      end

      STDERR.print "\n"
    end

    print csv_string

  end
end
