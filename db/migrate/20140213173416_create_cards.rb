class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
    	t.references :user

    	t.string		:customer_token, limit: 24, null: false
    	t.string 		:last4, limit: 4, null: false
    	t.integer		:exp_month, null: false
    	t.integer		:exp_year, null: false
      t.timestamps
    end

    add_index :cards, :user_id
  end
end
