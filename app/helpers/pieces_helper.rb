module PiecesHelper

  def link_to_piece piece
    if piece.is_a? Article or piece.is_a? Lesson
      link_to piece.title, piece_url(issue: piece.issue.number, key: piece.author_slug, type: piece.class.name.underscore.to_sym)
    end
  end

  def topic_links_for piece, tag_name = :span, options = {}

    options.reverse_merge!({ class: 'piece-unit-topics' })
    topics = piece.enabled_topics

    return nil if topics.size == 0

    content_tag tag_name, options do
      "On #{topics.map { |topic| link_to(topic.name.titlecase, topic_path(topic: topic.name.downcase)) }.join(', ')}".html_safe
    end
  end

end
