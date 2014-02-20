module IssuesHelper

	def illustration_tag issue, key, variant = 'small'
		image_tag "illustrations/issues/#{issue}/#{key}/#{variant}.jpg"
	end

	def portrait_tag issue, key
    image_tag "authors/issues/#{issue}/#{key}.jpg"
	end

	def due_on issue
		if issue.published?
			"immediately"
		else
			distance_of_time_in_words(Date.today, issue.published_on)
		end
	end
end
