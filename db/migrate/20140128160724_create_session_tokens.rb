class CreateSessionTokens < ActiveRecord::Migration
  def change
    create_table :session_tokens do |t|
    	t.references    :email_address
    	t.string				:token, :null => false, :limit => 32
    	t.datetime			:used_at, :null => true
    	t.string				:user_agent, :null => true, :limit => 500
    	t.string				:ip_address, :null => true, :limit => 16

      t.timestamps
    end
  end
end
