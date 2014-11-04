# small script to extract the data we need to import from the legacy system

File.open('/tmp/orders.csv','w') do |f|
  f.write "Email,First Name,Last Name,Subscription start issue, Issues unshipped, Refund Number, Order No, Order at, Paid at, Shipping Company, Shipping Address 1, Shipping Address 2, Shipping town, Shipping county, Shipping Postcode, Shipping Country\n"

  LineItem.where(product_id: 1).joins(:order).includes(:order => :customer).where('orders.paid_at IS NOT NULL AND orders.refund = 0 AND start_issue > 1').all.each do |li|

    f.write "#{li.order.customer.email},#{li.order.customer.billing_first_name.strip},#{li.order.customer.billing_last_name.strip},#{li.start_issue},#{li.start_issue - 1},#{li.order.refund_number},#{li.order.name},#{li.order.created_at},#{li.order.paid_at}, \"#{li.order.shipping_company}\", \"#{li.order.shipping_address_1}\", \"#{li.order.shipping_address_2}\", \"#{li.order.shipping_town}\", \"#{li.order.shipping_county}\", #{li.order.shipping_postcode}, #{li.order.shipping_country.try(:iso)}\n"
  end
end
