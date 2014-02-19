class SupportController < ApplicationController

  skip_before_filter :authenticate_user!

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

    rescue
      flash[:warning] = "Error confirming credit card"
      render :show and return
    end

    redirect_to thanks_support_path

  end

  def thanks
    @address = Address.new
  end

  protected

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
