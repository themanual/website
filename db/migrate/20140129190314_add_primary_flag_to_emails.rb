class AddPrimaryFlagToEmails < ActiveRecord::Migration
  def change
  	add_column :email_addresses, :primary, :boolean, :default => false, :null => false
  end
end
