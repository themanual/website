class Subscription < ActiveRecord::Base
	validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 10 }

	belongs_to :user



  def place_order issue
    product = Shoppe::Product.with_attributes('issue_number', issue.number).with_attributes(:format, product_level).first

    if product.nil?
      # uh-oh throw an error
      Airbrake.notify StandardError.new("Could not find a Shoppe product for Issue ##{issue.number} #{product_level} when placing subscription order")
      return
    end

    order = Shoppe::Order.new first_name: user.first_name,
                              last_name: user.last_name,
                              billing_address1: user.shipping_address.lines_as_one,
                              billing_address3: user.shipping_address.city,
                              billing_address4: user.shipping_address.region,
                              billing_postcode: user.shipping_address.post_code,
                              billing_country_id: user.shipping_address.country_id,
                              email_address: user.email,
                              phone_number: '0000000'


    order.properties['stripe_customer_token'] = user.current_card.customer_token
    order.save

    order.order_items.add_item product, 1
    order.save

    # TODO shipping

    order.confirm!
    order.accept!

    if issue.published?
      # order.ship!
    end

  end

  def product_level
    case
    when price >= 10
      :digital
    when price >= 20
      :print
    end
  end
end
