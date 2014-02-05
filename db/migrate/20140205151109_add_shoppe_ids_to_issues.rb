class AddShoppeIdsToIssues < ActiveRecord::Migration
  def change
  	add_column	:issues, :shoppe_permalink_digital, :string, limit: 64, null: true
  	add_column	:issues, :shoppe_permalink, :string, limit: 64, null: true
  end
end
