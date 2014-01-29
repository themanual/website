class SessionsMailer < TheManual::Mailer

	def login_token token
		@token = token

		mail to: token.email_address.email, subject: 'Login to The Manual'
	end
end
