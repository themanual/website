class AddPublishedFieldsToIssues < ActiveRecord::Migration
  def change
  	add_column :issues, :published_on, :date, null: true
  	add_column :issues, :public, :boolean, null: false, default: false
  end
end
