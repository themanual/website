class SessionsController < Devise::SessionsController

	def new
		render :new
	end

	def create
		if params[:token]
			# look up token
			# if valid
				# login via token
			# otherwise 'not found' page
		elsif params[:email]
			# look up email

			# if exists

				# create a new session_token
				# send login email with token link

			# othewise

				# render 'not found' page
		else
			render :new
		end
	end

end
