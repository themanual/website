class SupportController < ApplicationController
  def create


    begin
      customer = Stripe::Customer.create(
        :card  => params[:stripe_token]
      )

      u = User.create email: params[:email]

      customer.metadata = {id: u.id}
      customer.save

      card = customer.cards.first

      current_user.cards.create! customer_token: customer.id, last4: card.last4, exp_month: card.exp_month, exp_year: card.exp_year

    # rescue
    #   flash[:warning] = "Error confirmign credit card"
    #   redirect_to support_path
    end

  end
end
