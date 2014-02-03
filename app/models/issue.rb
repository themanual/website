class Issue < ActiveRecord::Base
	has_many :articles
	has_many :authors, through: :articles
	has_many :lessons

	belongs_to :volume

	# TODO use publish_date
	scope :ordered, -> { order('created_at DESC') }


	def self.public_issues
		Issue.where(number: [1,2,3])
	end
end
