class Volume < ActiveRecord::Base
	has_many :issues

	def name
		"Volume ##{self.number}"
	end
end
