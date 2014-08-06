module IssuesHelper

  def illustration_tag piece, options = {}
    options.reverse_merge!(variant: 'original', size: 'l')
    image_tag "illustrations/editorial/issue-#{piece.issue_number}/#{options[:variant]}/#{piece.author_slug}-#{options[:size]}.jpg"
  end

  def portrait_tag piece
    image_tag "illustrations/portraits/issue-#{piece.issue_number}/#{piece.author_slug}.jpg"
  end

  def due_on issue
    if issue.published?
      "immediately"
    else
      distance_in_minutes = ((issue.published_on.to_time - Date.today.to_time)/60.0).round

      days = (distance_in_minutes/1440.0).round
      weeks = (days/7.0).round
      months = (days/30.0).round # roughyl, good enough for us

      case distance_in_minutes

      # up to 7 days
      when 0..10080

        "#{days.to_words} day#{'s' unless days == 1}"

      # 1 to 6 weeks
      when 10080...60480

        "#{weeks.to_words} week#{'s' unless weeks == 1}"

      # more than 6 weeks
      else

        "#{months.to_words} month#{'s' unless months == 1}"

      end
    end
  end
end
