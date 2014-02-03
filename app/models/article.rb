class Article < Piece

	def lesson
		@lesson ||= self.issue.lessons.where(author_id: self.author_id).first
	end
end
