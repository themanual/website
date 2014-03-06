class DropSubscriptionOrders < ActiveRecord::Migration
  def change
    drop_table :subscription_orders
  end
end
