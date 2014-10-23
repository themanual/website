class AnonUser < OpenStruct
	include Singleton

	def initialize
		super anon?: true,
					access_level: 0
	end

  def can_view? item

    case item
    when Issue
      return item.published? || item.preview?
    when Piece

      # published
      return true if item.issue.published?

      # issue in preview and piece published
      return true if item.issue.preview? and item.published?

    else
      return false
    end

  end

end
