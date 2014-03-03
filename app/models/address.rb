class Address < ActiveRecord::Base
	belongs_to :user
	has_one :country, class_name: 'Shoppe::Country', foreign_key: :id

	validates_presence_of :lines, :message => "is required"
	validates_presence_of :city, :message => "is required"
	validates_presence_of :post_code, :message => "is required"
	validates_presence_of :country_id, :message => "is required"
end
