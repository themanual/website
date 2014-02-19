class AddMissingIndices < ActiveRecord::Migration
  def change
  	add_index :email_addresses, :user_id
  	add_index :issues, :volume_id
  	add_index :pieces, :issue_id
  	add_index :pieces, :author_id
  end
end
