class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
    	t.references 	:user, index: true
    	t.integer			:price, null: false, default: 10
    	t.integer			:free_shipping_count, null: false, default: 0

      t.timestamps
    end
  end
end
