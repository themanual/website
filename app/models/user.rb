class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  has_many :email_addresses, :dependent => :delete_all
  has_many :session_tokens, through: :email_addresses
  has_many :cards, :dependent => :delete_all
  has_many :addresses
  has_one :shipping_address, class_name: 'Address'
  has_many :subscriptions
  has_many :ownerships

  accepts_nested_attributes_for :addresses

  acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

  after_create :add_email_address

  def self.anon_user
    AnonUser.instance
  end

  def anon?
    false
  end

  def is_admin?
    access_level > 0
  end

  def can_view? item

    # check if the anon user can access this first
    #   no point running our logic if its open to the public
    if self.anon_user.can_view? item
      return true
    else
      case item
      when Issue
        # TODO
        #  - check purchases
        #  - check in-preview states
        return true
      when Piece
        return can_view?(item.issue)
      end

      return false
    end
  end

  def full_name
    name
  end

  def name
    "#{first_name} #{last_name}"
  end

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
end
