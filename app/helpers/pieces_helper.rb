module PiecesHelper

  def link_to_piece piece
    if piece.is_a? Article or piece.is_a? Lesson
      link_to piece.title, piece_url(issue: piece.issue.number, key: piece.author_slug, type: piece.class.name.underscore.to_sym)
    end
  end

  def bio_with_twitter author
    return author.bio.strip if author.twitter.blank?
    twitter_link_md = "[#{author.name}](https://twitter.com/#{author.twitter})"
    name_pattern = Regexp.new("^#{author.name}")
    return author.bio.strip.gsub(name_pattern, twitter_link_md)
  end

end