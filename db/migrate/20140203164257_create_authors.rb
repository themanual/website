class CreateAuthors < ActiveRecord::Migration
  def change
    create_table :authors do |t|
    	t.string		:name, 		null: false, default: '', limit: 128
    	t.string		:bio,  		null: false, default: '', limit: 256
    	t.string		:slug, 		null: false, default: '', limit: 128
    	t.string		:twitter, null: false, default: '', limit: 32
      t.timestamps
    end
  end
end
