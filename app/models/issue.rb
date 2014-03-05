class Issue < ActiveRecord::Base
	has_many :articles
	has_many :authors, through: :articles
	has_many :lessons
	has_many :subscription_orders

	belongs_to :volume
	belongs_to :shoppe, class_name: 'Shoppe::Product'
	belongs_to :shoppe_digital, class_name: 'Shoppe::Product'

	acts_as_cached(:version => 1, :expires_in => 1.month) if ActionController::Base.perform_caching

	scope :ordered, -> { order('published_on DESC') }
	scope :published, -> { where(['published_on < ?', Time.now]) }
	scope :public, -> { where(public: true) }

	def title
		"Issue ##{self.number}"
	end

	def purchasable?
		Shoppe::Product.with_attributes(:issue_number, self.number).any?
	end

	def shoppe_item format = :print
		Shoppe::Product.with_attributes(:issue_number, self.number).with_attributes(:format, format).first
	end

	def published?
		self.published_on < Time.now
	end

	# TODO: horribly inneficient, sort this out later Marc
	def next
		@next ||= Issue.where(number: 1 + self.number).first
	end

	def self.public_issues
		Rails.cache.fetch('issues:public', expires_in: 1.hour) do
			Issue.published.ordered.public
		end
	end

	def self.latest
		Rails.cache.fetch('issues:latest', expires_in: 1.day) do
			Issue.published.ordered.limit(1).first
		end
	end

	def self.clear_caches
		['issues:public','issues:latest'].each do |key|
			Rails.cache.delete key
		end
	end
end
