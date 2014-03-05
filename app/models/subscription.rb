class Subscription < ActiveRecord::Base
	validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 10 }

	belongs_to :user

  has_many :subscription_orders
end
