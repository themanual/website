class CreateEmailAddresses < ActiveRecord::Migration
  def change
    create_table :email_addresses do |t|

    	t.string			:email
    	t.references 	:user


      t.timestamps
    end

    add_index :email_addresses, :email, :unique => true
  end
end
