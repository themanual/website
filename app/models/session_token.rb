class SessionToken < ActiveRecord::Base
	belongs_to :email_address



	def self.login_token_expiry
		24.hours.from_now
	end
	def self.marketing_token_expiry
		7.days.from_now
	end
end
