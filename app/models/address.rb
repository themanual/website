class Address < ActiveRecord::Base
	belongs_to :user
	belongs_to :country, class_name: 'Shoppe::Country'

	validates_presence_of :lines, :message => "is required"
	validates_presence_of :city, :message => "is required"
	# validates_presence_of :post_code, :message => "is required"
	validates_presence_of :country_id, :message => "is required"

  def lines_as_one
    lines.split.join(', ')
  end

  def full_text
    [lines, city, region, post_code, country.name].reject(&:blank?).join("\n")
  end

  def name # for active_admin
    [lines, city, region, post_code, country.name].reject(&:blank?).join(", ")
  end

  def self.blank_address
    Address.new lines: ' ',
                city: ' ',
                region: ' ',
                post_code: ' ',
                country_id: ' '
  end
end
