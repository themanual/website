class AddShippedToOwnerships < ActiveRecord::Migration
  def change
    add_column :ownerships, :shipped, :boolean, null: false, default: false
  end
end
