class Address < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :line1, :message => "is required"
	validates_presence_of :county, :message => "is required"
	validates_presence_of :post_code, :message => "is required"
	validates_presence_of :country, :message => "is required"
end
