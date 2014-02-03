class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
    	t.integer			:number, null: false, default: 1
    	t.references	:volume
      t.timestamps
    end
  end
end
