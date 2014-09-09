class Article < Piece

  def lesson
    @lesson ||= self.issue.lessons.where(author_id: self.author_id).first
  end

  def illo_basepath
    "illustrations/editorial/issue-#{self.issue_number}/#{self.illustrator.parameterize}"
  end

  def to_partial_path
    'pieces/piece'
  end
end
