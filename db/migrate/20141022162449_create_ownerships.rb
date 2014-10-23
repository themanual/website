class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|

      t.references :user, index: true, null: false
      t.references :issue, index: true, null: false
      t.string     :level, limit: 10, null: false, default: :web
      t.references :subscription, index: true, null: true

      t.timestamps
    end
  end
end
