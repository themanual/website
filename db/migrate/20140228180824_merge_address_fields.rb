class MergeAddressFields < ActiveRecord::Migration
  def change
    add_column :addresses, :lines, :string, before: :city, limit: 512, null: false, default: ''
    remove_column :addresses, :line1
    remove_column :addresses, :line2
    remove_column :addresses, :line3
  end
end
