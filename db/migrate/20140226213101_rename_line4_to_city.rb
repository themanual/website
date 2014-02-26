class RenameLine4ToCity < ActiveRecord::Migration
  def change
    rename_column :addresses, :line4, :city
  end
end
