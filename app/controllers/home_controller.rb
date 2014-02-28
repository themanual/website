require 'open-uri'

class HomeController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:shipping_estimate]

  def shipping_estimate

    begin
      raise ActionController::InvalidAuthenticityToken unless form_authenticity_token == params[:authenticity_token]

      if params[:country].present?
        country = params[:country]
        city = params[:city] || ''
        region = params[:region] || ''
        zip = params[:post_code] || ''
      else
        geo_ip = MultiJson.load(open("http://freegeoip.net/json/#{request.remote_ip}"))
        country = ip_country = geo_ip['country_code']
        ip_country_name = geo_ip['country_name']
        region = geo_ip['region_name']
        city = geo_ip['city']
        zip = geo_ip['zipcode']
      end

      order = Shipwire::Order.new(nil)
      order.address = {
        address1: (params[:line1] || ''),
        city: city,
        country: country,
        state: region,
        zip: zip
      }
      order.add_item Shipwire::OrderItem.new('C85NOT001', 1) # use Issue.latest when we have shipwire data in there

      rates = Shipwire::Api.new.rate(order)

      quotes = rates['RateResponse']['Order']['Quotes']

      if quotes.nil?
        render json: {status: 'missing'}

      else
        quote = quotes['Quote'].first

        render json: {
          status: :ok,
          response: {
            ip_country: ip_country,
            ip_country_name: (defined?(ip_country_name) ? ip_country_name : ''),
            service: quote['method'],
            warehouse: quote['Warehouse'],
            carrier_code: quote['Service']['__content__'],
            cost: quote['Cost']['__content__']
          }
        }
      end
    rescue ActionController::InvalidAuthenticityToken
      render json: {status: 'error'}, status: 403
    rescue Exception => e
      Airbrake.notify_airbrake e
      render json: {status: 'error'}
    end
  end
end
