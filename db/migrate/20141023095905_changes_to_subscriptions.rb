class ChangesToSubscriptions < ActiveRecord::Migration
  def change
    remove_column :subscriptions, :price
    remove_column :subscriptions, :free_shipping_count

    add_column    :subscriptions, :start_date, :date, null: false
    add_column    :subscriptions, :issues_duration, :integer, null: false, default: 3
    add_column    :subscriptions, :issues_remaining, :integer, null: false, default: 3
    add_column    :subscriptions, :level, :string, null: false, limit: 10, default: 'web'
    add_column    :subscriptions, :status, :integer, null: false, default: 0
  end
end
