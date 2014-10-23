class User::EmailsController < ApplicationController
  before_filter :authenticate_user!

	def create
		if (@email = current_user.email_addresses.create email_params)
			redirect_to account_path
		else
			render 'user/account/show'
		end
	end

	def update
		if params[:primary]
			if (email = current_user.email_addresses.find(params[:id]))
				email.update_attributes primary: true
			end
		end
		redirect_to account_path
	end

	protected

		def email_params
			params.require(:email_address).permit(:primary, :email)
		end
end
