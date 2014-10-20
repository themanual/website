require 'open-uri'

class HomeController < ApplicationController

  skip_before_filter :authenticate_user!, only: [:shipping_estimate, :geoip]

  def index
    metadata "og:title", "The Manual Everywhere"
    metadata "twitter:card", "summary_large_image"
    metadata "description", "The Manual is moving beyond print. And it’s going everywhere you want."
    metadata "og:image", view_context.image_url("misc/ks-illustration-1000w.png")
    redirect_to read_path
  end

  def cart
    @latest = Issue.latest
    @tier = params[:tier]
    @tier ||= 'print'
    @user = User.new
    @address = Address.new
    render layout: "payment"
  end

  def geoip
    geo_ip = {}
    open("http://freegeoip.net/json/#{Rails.env.development? ? nil : request.remote_ip}", read_timeout: 3) do |http|
      geo_ip = MultiJson.load(http.read)
    end
    render json: {
      status: :ok,
      response: geo_ip
    }
  end

  def shipping_estimate

    begin
      raise ActionController::InvalidAuthenticityToken unless form_authenticity_token == params[:authenticity_token]

      if params[:country].present?
        country = params[:country]
        city = params[:city] || ''
        region = params[:region] || ''
        zip = params[:post_code] || ''
      else
        geo_ip = {}
        open("http://freegeoip.net/json/#{Rails.env.development? ? nil : request.remote_ip}", read_timeout: 3) do |http|
          geo_ip = MultiJson.load(http.read)
        end
        country = ip_country = geo_ip['country_code']
        ip_country_name = geo_ip['country_name']
        region = geo_ip['region_name']
        city = geo_ip['city']
        zip = geo_ip['zipcode']
      end

      order = Shipwire::Order.new(nil)
      order.address = Shipwire::Address.new( {address1: (params[:lines] || ''),
                                              city: city,
                                              country: country,
                                              state: region,
                                              zip: zip
                                            }, false)

      order.add_item Shipwire::OrderItem.new('MNUISS003', 1) # use Issue.latest when we have shipwire data in there

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
      render json: {status: 'error', message: 'not authorized'}, status: 403
    rescue Net::OpenTimeout, Shipwire::ApiTimeout
      render json: {status: 'error', message: 'api timeout'}
    rescue Exception => e
      Airbrake.notify e
      render json: {status: 'error'}
    end
  end

end
