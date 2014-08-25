class Article < Piece

	def lesson
		@lesson ||= self.issue.lessons.where(author_id: self.author_id).first
	end

  def illo_basepath
    "illustrations/editorial/issues/#{self.issue_number}/#{self.author_slug}"
  end
end
