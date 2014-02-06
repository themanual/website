class SwitchProductSlugsToIds < ActiveRecord::Migration
  def change
  	add_column	:issues, :shoppe_digital_id, :integer, null: true
  	add_column	:issues, :shoppe_id, :integer, null: true

    # Issue.reset_column_information

  	Issue.all.each do |issue|
  		if issue.shoppe_permalink
  			issue.shoppe_id = Shoppe::Product.find_by_permalink!(issue.shoppe_permalink).id
  		end

  		if issue.shoppe_permalink_digital
  			issue.shoppe_digital_id = Shoppe::Product.find_by_permalink!(issue.shoppe_permalink_digital).id
  		end

      issue.save!
  	end

  	remove_column :issues, :shoppe_permalink_digital
  	remove_column :issues, :shoppe_permalink
  end
end
