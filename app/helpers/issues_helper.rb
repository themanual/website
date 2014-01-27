module IssuesHelper

	def illustration_tag issue, key, variant = 'small'
		image_tag "illustrations/issues/#{issue}/#{key}/#{variant}.jpg"
	end

	def portrait_tag issue, key
    image_tag "authors/issues/#{issue}/#{key}.jpg"
	end
end
