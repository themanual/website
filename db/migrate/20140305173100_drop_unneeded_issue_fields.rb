class DropUnneededIssueFields < ActiveRecord::Migration
  def change
    remove_column :issues, :shoppe_id
    remove_column :issues, :shoppe_digital_id
  end
end
