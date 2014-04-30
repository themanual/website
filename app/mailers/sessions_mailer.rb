class SessionsMailer < TheManual::Mailer

	def login_token user, token
    @token = token
    @user = user

		mail to: token.email_address.email, subject: 'Log in to The Manual'
	end
end
