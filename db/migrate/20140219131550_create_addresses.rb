class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
    	t.references  :user, index: true

    	t.string 			:line1, limit: 128, null: false
    	t.string 			:line2, limit: 128, null: true
    	t.string 			:line3, limit: 128, null: true
    	t.string 			:line4, limit: 128, null: true
    	t.string			:county, limit: 128, null: false
    	t.string  		:post_code, limit: 32, null: false
    	t.string  		:country, limit: 128, null: false

      t.timestamps
    end

    add_column :users, :shipping_address_id, :integer, null: true
  end
end
