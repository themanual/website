class AddStaffPicks < ActiveRecord::Migration
  def change
    add_column :pieces, :staff_pick_at, :datetime, null: true
    add_column :pieces, :staff_pick, :boolean, null: false, default: false

    add_index :pieces, :staff_pick_at
  end
end
