class Piece < ActiveRecord::Base
  STAFF_PICK_CACHE_KEY = "pieces:staff_pick_updated_at"
  ACTIVE_TOPICS_CACHE_KEY = "topics:active"

  belongs_to :author
  belongs_to :issue, touch: true

  validates_presence_of :body, :on => :create, :message => "is required"

  acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  acts_as_taggable_on :topics

  scope :ordered, -> { order('position ASC') }
  scope :staff_picks, -> { where('staff_pick_at IS NOT NULL').order('staff_pick_at DESC') }
  scope :not_from_issue, -> (issue) { where('issue_id NOT IN (?)', issue.id) }

  def issue_number
    @issue_number ||= issue.number
  end

  def author_slug
    @author_slug ||= author.slug
  end

  def recommended
    # for now just pick a staff pick at random, in future try to use topics to find a match
    # https://github.com/themanual/website/issues/20
    # Fetch a random pick from another issue
    @recommended ||= Piece.staff_picks.not_from_issue(self.issue).sample
    # If there are no picks in other issues, pick any
    @recommended ||= Piece.staff_picks.sample
  end

  def path
    if self.is_a? Article or self.is_a? Lesson
      Rails.application.routes.url_helpers.piece_path issue_number, author_slug, type.downcase
    end
  end

  def pick!
    self.update_attributes staff_pick: true, staff_pick_at: Time.now
    Piece.latest_staff_pick_cache_clear
  end

  def unpick!
    update_attributes staff_pick: false, staff_pick_at: nil
    Piece.latest_staff_pick_cache_clear
  end

  def article?
    self.is_a? Article
  end

  def lesson?
    self.is_a? Lesson
  end

  def type
    self.class.name.downcase
  end

  def type_sym
    self.type.underscore.to_sym
  end

  def enabled_topics
    self.topics.where(enabled: true)
  end

  def disabled_topics
    self.topics.where(enabled: false).where('taggings_count > 1')
  end

  def freestanding_title
    case type
    when "Lesson"
      return "#{self.author.name.possessive } Lesson"
    else
      return self.title
    end
  end

  def topics_upto(limit = nil)
    returns = self.enabled_topics
    remaining = limit ? limit - returns.count : nil
    returns << self.disabled_topics.order(taggings_count: :desc).limit(remaining) unless remaining.is_a?(Numeric) && remaining <= 0
    returns.flatten.sort_by(&:name)
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
    Rails.cache.delete ACTIVE_TOPICS_CACHE_KEY
  end

  def self.active_topics
    Rails.cache.fetch ACTIVE_TOPICS_CACHE_KEY do
      Piece.tag_counts_on(:topics).where(enabled: true).collect(&:name).sort
    end
  end

  def self.latest_staff_pick
    Rails.cache.fetch STAFF_PICK_CACHE_KEY do
      Piece.staff_picks.order('staff_pick_at DESC').select(:staff_pick_at).limit(1).first.staff_pick_at.to_i
    end
  end

  def self.latest_staff_pick_cache_clear
    Rails.cache.delete STAFF_PICK_CACHE_KEY
  end
end
