class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  has_many :email_addresses
  has_many :session_tokens, through: :email_addresses


  # ensure devise always 'remembers' users
  def remember_me
    true
  end
end
