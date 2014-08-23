class Piece < ActiveRecord::Base
  TOPIC_MIN_PIECE_COUNT = 1

  belongs_to :author
  belongs_to :issue, touch: true

  validates_presence_of :body, :on => :create, :message => "is required"

  acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  acts_as_taggable_on :topics

  scope :ordered, -> { order('position ASC') }
  scope :staff_picks, -> { where('staff_pick_at IS NOT NULL').order('staff_pick_at DESC') }

  def issue_number
    @issue_number ||= issue.number
  end

  def author_slug
    @author_slug ||= author.slug
  end

  def recommended
    # for now just pick a staff pick at random, in future try to use topics to find a match
    # https://github.com/themanual/website/issues/20
    @recommended ||= Piece.staff_picks.sample
  end

  def path
    if self.is_a? Article or self.is_a? Lesson
      Rails.application.routes.url_helpers.piece_path issue_number, author_slug, type.downcase
    end
  end

  def pick!
    self.update_attributes staff_pick: true, staff_pick_at: Time.now
  end

  def unpick!
    update_attributes staff_pick: false, staff_pick_at: nil
  end

  def article?
    self.is_a? Article
  end

  def lesson?
    self.is_a? Lesson
  end

  def type
    return self.class.name
  end

  def companion
    @companion ||= begin
      if self.article?
        Lesson.where(issue_id: self.issue_id, author_id: self.author_id).first
      elsif self.lesson?
        Article.where(issue_id: self.issue_id, author_id: self.author_id).first
      end
    end
  end

  def prev
    if self.is_a? Lesson

      return Article.where(issue_id: self.issue_id, author_id: self.author_id).first rescue nil

    elsif self.is_a? Article

      return Lesson.where(issue_id: self.issue_id)
                   .where("position < #{self.position}")
                   .order('position DESC')
                   .limit(1)
                   .first rescue nil
    end
  end

  def next

    if self.is_a? Article

      return Lesson.where(issue_id: self.issue_id, author_id: self.author_id).first rescue nil

    elsif self.is_a? Lesson

      return Article.where(issue_id: self.issue_id)
                    .where("position > #{self.position}")
                    .order('position ASC')
                    .limit(1)
                    .first rescue nil

    end
  end

  def self.active_topics_cache_clear
    Rails.cache.delete Piece.active_topics_cache_key
  end

  def self.active_topics_cache_key
    "topics:active"
  end

  def self.active_topics
    Rails.cache.fetch Piece.active_topics_cache_key do
      Piece.tag_counts_on(:topics).where(enabled: true).collect(&:name).sort
    end
  end
end
