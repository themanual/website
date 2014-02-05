class AnonUser < OpenStruct
	include Singleton

	def initialize
		super anon?: true,
					access_level: 0
	end

end