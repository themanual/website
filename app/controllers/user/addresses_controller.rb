class User::AddressesController < ApplicationController
  before_filter :authenticate_user!

  def show
    @address = current_user.shipping_address || current_user.addresses.new
  end

  def create
    @address = current_user.addresses.new address_params
    if (@address.save)
      current_user.update_attribute(:shipping_address_id, @address.id)
      redirect_to account_path
    else
      render :index
    end
  end

  private

    def address_params
      params.require(:address).permit(:lines, :city, :region, :post_code, :country_id)
    end
end
