class MakeTokenLonger < ActiveRecord::Migration
  def change
  	change_column :session_tokens, :token, :string, limit: 64, null: false
  end
end
