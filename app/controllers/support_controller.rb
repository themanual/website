class SupportController < ApplicationController
  def show
    @user = User.new
  end
  def create
    begin

      user = User.new user_params
      customer = Stripe::Customer.create(
        :card  => params[:stripe_token]
      )

      customer.metadata = {id: u.id}
      customer.save

      card = customer.cards.first

      current_user.cards.create! customer_token: customer.id, last4: card.last4, exp_month: card.exp_month, exp_year: card.exp_year

    rescue
      flash[:warning] = "Error confirming credit card"
      user.destroy if user && user.persisted?

      # rebuild @user to show details in the form
      @user = User.new user_params
      render :show
    end

  end

  protected

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end
end
