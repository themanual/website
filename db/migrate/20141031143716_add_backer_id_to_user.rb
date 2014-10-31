class AddBackerIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :backer_id, :integer, null: true
  end
end
