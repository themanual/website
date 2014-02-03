class CreateVolumes < ActiveRecord::Migration
  def change
    create_table :volumes do |t|
    	t.integer		:number, null: false, default: 1

      t.timestamps
    end
  end
end
