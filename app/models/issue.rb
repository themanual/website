class Issue < ActiveRecord::Base
  NEW_PERIOD = 30.days

  enum status: {
    unpublished: 0,
    preview: 1,
    published: 2
  }

  has_many :pieces
  has_many :articles
  has_many :lessons
  has_many :authors, through: :articles
  has_many :downloads
  has_many :ownerships

  belongs_to :volume, touch: true

  acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  scope :ordered, -> { order('number DESC') }
  scope :publicly_visible, -> { where(status: [Issue.statuses[:published], Issue.statuses[:preview]]) }

  def title
    "Issue ##{self.number}"
  end

  def purchasable?
    Shoppe::Product.with_attributes(:issue_number, self.number.to_s).any?
  end

  def publicly_visible?
    preview? || published?
  end

  def shoppe_item format = :print
    Shoppe::Product.with_attributes(:issue_number, self.number.to_s).with_attributes(:format, format).first
  end

  def new?
    published_on > (Time.now - NEW_PERIOD)
  end

  # TODO: horribly inneficient, sort this out later Marc
  def next
    @next ||= Issue.where(number: 1 + self.number).first
  end

  def self.public_issues
    Rails.cache.fetch('issues:public', expires_in: 1.hour) do
      Issue.publicly_visible.ordered
    end
  end

  def self.latest
    Rails.cache.fetch('issues:latest', expires_in: 1.hour) do
      Issue.ordered.first
    end
  end

  def self.clear_caches
    ['issues:public'].each do |key|
      Rails.cache.delete key
    end
  end
end
