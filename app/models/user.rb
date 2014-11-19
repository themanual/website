class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  has_many :email_addresses, :dependent => :delete_all
  has_many :session_tokens, through: :email_addresses
  has_many :cards, :dependent => :delete_all
  has_many :addresses
  has_one  :shipping_address, class_name: 'Address'
  has_many :subscriptions
  has_many :ownerships

  accepts_nested_attributes_for :addresses

  acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  after_create :add_email_address

  def self.anon
    AnonUser.instance
  end

  def anon?
    false
  end

  def is_admin?
    access_level > 0
  end

  def can?(verb, item)

    if is_admin? || User.anon.can?(verb, item)
      return true
    end

    # Don't repeat what anons can already do
    case verb
    when :read
      case item
      when Issue
        return item.preview? && owns_issue?(item)
      when Piece
        return can?(:read, item.issue)
      end
    end

    return false
  end

  def visible_issues
    if is_admin?
      Issue.ordered
    else
      Issue.ordered.publicly_listed
    end
  end

  def owns_issue? issue
    self.ownerships.where(issue_id: issue.id).any?
  end

  def name
    "#{first_name} #{last_name}"
  end
  alias_method :full_name, :name

  # ensure devise always 'remembers' users
  def remember_me
    true
  end

  def add_email_address
  	self.email_addresses.create email: self.email, primary: true
  end

  def current_card
    cards.latest.first
  end

  def issues_with_downloads
    Issue.joins(:ownerships).includes(:ownerships, :downloads).where("ownerships.user_id = ? AND ownerships.level <> 'web'", self.id).order('issues.id DESC, downloads.medium DESC, downloads.ordering ASC')
  end

  def current_subscriptions
    @current_subscriptions ||= subscriptions.active.to_a
  end
end
