namespace :themanual do

  desc "Ship an issue"
  task :ship_issue => :environment do

    Ownership.joins(:user)
      .includes(:user)
      .where('subscription_id IS NOT NULL') # ownerships that came via subscriptions
      .where('users.backer_id IS NOT NULL') # is a backer
      .where(issue_id: Issue.find_by_number(ENV['ISSUE']).id) # this issue
      .where(level: %w(print full)) # physical product
      .where(shipped: false) # not yet shipped
      .all
      .each do |ownership|


      address = ownership.user.shipping_address

      begin

        address_lines = address.lines.split("\n")

        order = Shipwire::Order.new("SUB#{'%06d' % ownership.subscription_id}-ISS#{'%03d' % ENV['ISSUE']}")
        order.address = Shipwire::Address.new( {
                                                name: address.user.name,
                                                email: address.user.email,
                                                address1: (address_lines[0] || ''),
                                                address2: (address_lines[1] || ''),
                                                address3: (address_lines[2..-1] || []).join(", "),
                                                city: address.city,
                                                country: address.country.code2,
                                                state: address.region,
                                                zip: address.post_code
                                              }, false)

        order.add_item Shipwire::OrderItem.new("MNUISS00#{ENV['ISSUE']}", 1)

        shipwire_order = Shipwire::Api.new.order!(order)

        if shipwire_order['errors']
          raise Shipwire::Error.new(shipwire_order['errors'].first['message'])
        else
          ownership.update_attribute :shipped, true
          print "Shipped Issue to #{address.user.name}\n"
        end


      rescue Net::OpenTimeout, Net::ReadTimeout, Shipwire::ApiTimeout
        print "Couldn't ship to #{address.user.name}, connection timed out\n"
      rescue Shipwire::Error => e
        print "Couldn't ship to #{address.user.name}, #{e.message}\n"
      rescue Interrupt => e
        raise e
      rescue Exception => e
        raise e
      end

    end

  end
end
