class Issue < ActiveRecord::Base
	has_many :articles
	has_many :authors, through: :articles
	has_many :lessons

	belongs_to :volume

	acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

	# TODO use publish_date
	scope :ordered, -> { order('created_at DESC') }


	def self.public_issues
		Issue.where(number: [1,2,3])
	end

	def purchasable?
		self.shoppe_permalink.present? or self.shoppe_permalink_digital.present?
	end

	def shoppe_item item = :physical
		case item
		when :digital
			self.shoppe_permalink_digital && Shoppe::Product.find_by_permalink!(self.shoppe_permalink_digital)
		when :physical
			self.shoppe_permalink && Shoppe::Product.find_by_permalink!(self.shoppe_permalink)
		end
	end
end
