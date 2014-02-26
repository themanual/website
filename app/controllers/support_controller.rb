class SupportController < ApplicationController

  PRICES = ActiveSupport::HashWithIndifferentAccess.new(digital: 10, print: 20, friend: 50)

  skip_before_filter :authenticate_user!
  before_filter :load_latest

  def show

  end

  def checkout
    @tier = params[:tier]

    # TODO throw/handle an error if now matching tier found

    @user = User.new
    @address = Address.new
  end

  def create
    begin

      # TODO validatate params[:tier]

      @user = User.new user_params
      customer = Stripe::Customer.create(
        :card  => params[:stripe_token]
      )

      card = customer.cards.first

      @user.cards.new customer_token: customer.id, last4: card.last4, exp_month: card.exp_month, exp_year: card.exp_year
      @user.save!
      @user.update_attribute :shipping_address_id, @user.addresses.first.id
      sign_in @user

      customer.metadata = {id: @user.id}
      customer.save

      # create subscription
      @user.subscriptions.create price: PRICES[params[:tier]]

      # create order

    rescue Stripe::StripeError
      flash[:warning] = t 'errors.stripe'
      render :show and return
    end

    redirect_to thanks_support_path

  end

  def thanks
    @address = Address.new
  end

  protected

    def load_latest
      @latest = Issue.latest
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, addresses_attributes: [:line1, :line2, :line3, :line4, :county, :post_code, :country_id])
    end
end
