class SupportController < ApplicationController

  skip_before_filter :authenticate_user!, unless: Proc.new { Rails.env.stage? }
  before_filter :load_latest

  def show
    @shipping = {price: '$10', country: 'Germany'}
  end

  def checkout
    @tier = params[:tier]

    # TODO throw/handle an error if now matching tier found

    @user = User.new
    @address = Address.new
  end

  def create

    redirect_to thanks_subscribe_path and return if Rails.env.stage?

    begin

      # TODO validatate params[:tier]

      ActiveRecord::Base.transaction do

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
        sub = @user.subscriptions.create :price => Subscription::TIERS[params[:tier]][:price]

        # create order
        sub.place_order Issue.latest # TODO get issue based on choice
      end

    rescue Stripe::StripeError
      flash[:warning] = t 'errors.stripe'
      render :show and return
    end

    redirect_to thanks_subscribe_path

  end

  def thanks
    @address = Address.new
  end

  protected

    def load_latest
      @latest = Issue.latest
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, addresses_attributes: [:lines, :city, :region, :post_code, :country_id])
    end
end
