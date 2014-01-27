class Piece
	class InvalidPiece < Exception; end

	attr_reader :issue, :key, :type, :metadata

	def initialize issue, key, type

		if !ISSUES[:published_issues].include?(issue) ||
				ISSUES[:issue][issue][key].nil? ||
				ISSUES[:issue][issue][key][type].nil?

			raise InvalidPiece

		end


		@issue = issue
		@key = key
		@type = type
		@metadata = ISSUES[:issue][issue][key]

	end

	def issue_keys
		ISSUES[:issue][issue].keys
	end

	def cache_key
		"piece:#{self.issue}:#{self.key}:#{self.type}"
	end
	def cache_ttl
		86400 # 1 day for now
	end

	def random
		return @random if @random

		random_issue = (ISSUES[:published_issues] - [self.issue]).sample
		random_key = ISSUES[:issue][random_issue].keys.sample

		return @random = Piece.new(random_issue, random_key, 'article')
	end

	def next


		if type == 'article'
			return Piece.new(issue, key, 'lesson') rescue nil
		elsif type == 'lesson'

			keys = issue_keys

			while keys.size > 0
				next_key = keys.shift

				if next_key == key && keys.size > 0
					return Piece.new(issue, keys.first, 'article') rescue nil
				end
			end

			return nil

		end

	end

	def prev
		if type == 'lesson'
			return Piece.new(issue, key, 'article') rescue nil
		elsif type == 'article'

			keys = issue_keys

			while keys.size > 0
				prev_key = keys.pop

				if prev_key == key && keys.size > 0
					return Piece.new(issue, keys.last, 'lesson') rescue nil
				end
			end

			return nil

		end

	end

end