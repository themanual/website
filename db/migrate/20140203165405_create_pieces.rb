class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
    	t.string			:type, null: false, limit: 32, default: 'Article'
    	t.references 	:author
    	t.references  :issue

    	t.string			:title,       null: false, default: '', limit: 256
    	t.text				:body,        null: false, default: ''
      t.string      :synopsis,    null: true, limit: 1024
      t.string      :illustrator, null: true, limit: 128

      t.integer     :position,    null: false, default: 1

      t.timestamps
    end
  end
end
