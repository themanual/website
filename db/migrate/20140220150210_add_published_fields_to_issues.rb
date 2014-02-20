class AddPublishedFieldsToIssues < ActiveRecord::Migration
  def change
  	add_column :issues, :published_on, :date, null: true
  	add_column :issues, :public, :boolean, null: false, default: false

  	Issue.where(number: 1).update_all public: true, published_on: Date.new(2012,1,1)
  	Issue.where(number: 2).update_all public: true, published_on: Date.new(2012,5,1)
  	Issue.where(number: 3).update_all public: true, published_on: Date.new(2012,9,1)
  end
end
