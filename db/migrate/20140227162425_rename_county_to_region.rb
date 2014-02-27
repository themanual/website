class RenameCountyToRegion < ActiveRecord::Migration
  def change
    rename_column :addresses, :county, :region
  end
end
