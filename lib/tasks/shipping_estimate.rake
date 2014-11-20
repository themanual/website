namespace :themanual do

  desc "Estimate shipping for an issue"
  task :shipping_estimate => :environment do

    i = 0
    csv_string = CSV.generate do |csv|

      csv << ['Subscription ID', 'User ID', 'Name', 'Address', 'Shipping Currency', 'Shipping Cost', 'Ship from', 'Ship method', 'Error?']


      Subscription.includes(:user => {:shipping_address => :country}).active.has_shipping.with_issue(ENV['ISSUE'].to_i).each do |sub|

        if ENV['LIMIT']
          i = i + 1
          next if i > ENV['LIMIT'].to_i
        end

        address = sub.user.shipping_address

        data = [sub.id, sub.user.id, sub.user.name, sub.user.shipping_address.name]

        begin

          order = Shipwire::Order.new(nil)
          order.address = Shipwire::Address.new( {address1: (address.lines || ''),
                                                  city: address.city,
                                                  country: address.country.code2,
                                                  state: address.region,
                                                  zip: address.post_code
                                                }, false)

          order.add_item Shipwire::OrderItem.new("MNUISS00#{ENV['ISSUE']}", 1)

          rates = Shipwire::Api.new.rate(order)


          quotes = rates['RateResponse']['Order']['Quotes']

          # print rates['RateResponse']['Order'].to_yaml

          if quotes.nil?
            costs[sub.id] = {error: 'no rates available'}
          else
            if quotes['Quote'].is_a? Hash
              quote = quotes['Quote']
            elsif quotes['Quote'].is_a? Array
              quote = quotes['Quote'].first
            else
              raise StandardError('Uh-oh')
            end

            data += [
              quote['Cost']['currency'],
              quote['Cost']['__content__'],
              quote['Warehouse']['__content__'],
              quote['Service']['__content__'], ''
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
