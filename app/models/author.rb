class Author < ActiveRecord::Base
	has_many :articles
	acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching
end
