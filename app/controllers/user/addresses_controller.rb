class User::AddressesController < ApplicationController

	def create
		@address = current_user.addresses.new address_params
		if (@address.save)
			redirect_to account_path
		else
			if params[:from_support]
				render 'support/thanks'
			else
				render 'user/account/show'
			end
		end
	end

	private

		def address_params
			params.require(:address).permit(:line1, :line2, :line3, :line4, :county, :post_code, :country)
		end
end
