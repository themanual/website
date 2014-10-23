class AddStartIssueToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :start_issue, :integer, null: false
  end
end
