class SupportController < ApplicationController
	def create

		u = User.create email: params[:email]

		customer = Stripe::Customer.create(
	    :card  => params[:stripe_token]
	  )
	end
end
