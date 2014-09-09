module PiecesHelper

  def link_to_piece piece
    if piece.is_a? Article or piece.is_a? Lesson
      link_to piece.title, piece_url(issue: piece.issue.number, key: piece.author_slug, type: piece.class.name.underscore.to_sym)
    end
  end

end