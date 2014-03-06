class Card < ActiveRecord::Base
	belongs_to :user

  scope :latest, -> { order('created_at DESC').limit(1) }

end
