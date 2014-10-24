class AnonUser < OpenStruct
  include Singleton

  def initialize
    super anon?: true,
          access_level: 0
  end

  def can_view? item

    case item
    when Issue
      return true unless item.unpublished?
    when Piece
      # issue is published
      return true if item.issue.published?
      # issue in preview but piece is published
      return true if item.issue.preview? and item.published?
    end

    return false

  end

  def visible_issues
    Issue.public_issues
  end

end
