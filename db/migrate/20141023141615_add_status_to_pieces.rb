class AddStatusToPieces < ActiveRecord::Migration
  def change
    add_column :pieces, :status, :integer, null: false, default: 0
  end
end
