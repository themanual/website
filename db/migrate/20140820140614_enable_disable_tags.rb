class EnableDisableTags < ActiveRecord::Migration
  def change
    add_column :tags, :enabled, :boolean, default: false, null: false
  end
end
