class AddExplicitExpiryToSessionToken < ActiveRecord::Migration
  def change
  	remove_column :session_tokens, :used_at
  	add_column :session_tokens, :expires_at, :datetime, :null => false, :default => '2000-01-01 00:00:00'

  	add_index :session_tokens, :token, :length => {token: 10}
  end
end
