require 'open-uri'

class HomeController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:shipping_estimate]

  def shipping_estimate

    begin
      geo_ip = MultiJson.load(open("http://freegeoip.net/json/#{ENV['REMOTE_ADDR']}"))

      country = geo_ip['country_code']

      order = Shipwire::Order.new(nil)
      order.address = {address1:'', city: '', country: country}
      order.add_item Shipwire::OrderItem.new('C85NOT001', 1) # use Issue.latest when we have shipwire data in there

      rates = Shipwire::Api.new.rate(order)

      render json: rates['RateResponse']['Order']['Quotes']['Quote'].first
    rescue Exception
      render nothing: true, status: 404
    end
  end
end
