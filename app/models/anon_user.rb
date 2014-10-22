class AnonUser < OpenStruct
	include Singleton

	def initialize
		super anon?: true,
					access_level: 0
	end

  def can_access? item

    case item
    when Issue
      return item.public?
    when Piece
      return can_access?(item.issue) # bubble up to the issue permissions until we add granular control of pieces
    else
      return false
    end

  end

end
