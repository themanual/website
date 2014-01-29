class EmailAddress < ActiveRecord::Base
	belongs_to :user
	has_many :session_tokens
end
