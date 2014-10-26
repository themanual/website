class AnonUser < OpenStruct
  include Singleton

  def initialize
    super anon?: true,
          access_level: 0
  end

  def can?(verb, item)
    case verb
    when :view
      case item
      when Issue
        return item.publicly_listed?
      when Piece
        return item.issue.publicly_listed?
      end
    when :read
      case item
      when Issue
        return item.published?
      when Piece
        return can?(:read, item.issue) || (item.issue.preview? && item.published?)
      end
    end
    return false
  end

  def visible_issues
    Issue.public_issues
  end

end
