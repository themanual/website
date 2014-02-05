class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  has_many :email_addresses
  has_many :session_tokens, through: :email_addresses

  after_create :add_email_address

  def self.anon_user
    AnonUser.instance
  end

  def anon?
    false
  end

  # ensure devise always 'remembers' users
  def remember_me
    true
  end

  def add_email_address
  	self.email_addresses.create email: self.email, primary: true
  end
end
