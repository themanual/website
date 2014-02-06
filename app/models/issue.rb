class Issue < ActiveRecord::Base
	has_many :articles
	has_many :authors, through: :articles
	has_many :lessons

	belongs_to :volume
	belongs_to :shoppe, class_name: 'Shoppe::Product'
	belongs_to :shoppe_digital, class_name: 'Shoppe::Product'

	acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

	# TODO use publish_date
	scope :ordered, -> { order('created_at DESC') }

	def title
		"Issue ##{self.number}"
	end

	def self.public_issues
		Issue.where(number: [1,2,3])
	end

	def purchasable?
		self.shoppe_id.present? or self.shoppe_digital_id.present?
	end

	def shoppe_item item = :physical
		case item
		when :digital
			Shoppe::Product.find(self.shoppe_digital_id)
		when :physical
			Shoppe::Product.find(self.shoppe_id)
		end
	end
end
