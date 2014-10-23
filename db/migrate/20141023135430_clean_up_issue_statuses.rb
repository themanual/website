class CleanUpIssueStatuses < ActiveRecord::Migration
  def change
    remove_column :issues, :public, :boolean, default: false

    add_column :issues, :status, :integer, null: false, default: 0


    Issue.where('number <= 3').update_all status: 2


  end
end
