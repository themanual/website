module PiecesHelper

  def link_to_piece piece
    if piece.is_a? Article or piece.is_a? Lesson
      link_to piece.title, piece_url(issue: piece.issue.number, key: piece.author_slug, type: piece.class.name.underscore.to_sym)
    end
  end

  def topic_links_for piece

    links = []

    piece.topics.where(enabled: true).each do |topic|
      links << link_to(topic.name.titlecase, topic_path(topic: topic.name.downcase))
    end

    if links.size > 0
      return content_tag :span, class: 'piece-unit-topics' do
        "On #{links.join(', ')}".html_safe
      end
    else
      return nil
    end
  end

end
