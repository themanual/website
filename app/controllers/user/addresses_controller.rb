class User::AddressesController < ApplicationController
  
  def index
    @address = current_user.addresses.last || current_user.addresses.new
  end

  def create
    @address = current_user.addresses.new address_params
    if (@address.save)

      # save as users shipping address if they don't have one (new user)
      if current_user.shipping_address_id.nil?
        current_user.update_attribute(:shipping_address_id, @address.id)

        # place order(s) as neccessary



      end

      redirect_to account_path
    else
      if params[:from_support]
        render 'support/thanks'
      else
        render 'user/account/show'
      end
    end
  end

  def edit
  end

  private

    def address_params
      params.require(:address).permit(:lines, :city, :region, :post_code, :country)
    end
end
