class SupportController < ApplicationController

  skip_before_filter :authenticate_user!
  before_filter :load_latest

  def show
    @user = User.new
  end
  def create
    begin

      @user = User.new user_params
      customer = Stripe::Customer.create(
        :card  => params[:stripe_token]
      )

      card = customer.cards.first

      @user.cards.new customer_token: customer.id, last4: card.last4, exp_month: card.exp_month, exp_year: card.exp_year
      @user.save!
      sign_in @user

      customer.metadata = {id: @user.id}
      customer.save

      # create subscription
      @user.subscriptions.create price: params[:price].to_i

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
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
