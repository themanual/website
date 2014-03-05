class CreateSubscriptionOrders < ActiveRecord::Migration
  def change
    create_table :subscription_orders do |t|
      t.references  :shoppe_order, index: true
      t.references  :subscription, index: true, null: false
      t.references  :issue, index: true, null: false

      t.string      :order_status, limit: 32, null: false, default: 'pending'
      t.text        :order_status_details

      t.timestamps
    end
  end
end
