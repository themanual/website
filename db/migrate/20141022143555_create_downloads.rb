class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.references  :issue, index: true, null: false
      t.string      :medium, limit: 10, null: false
      t.string      :format, limit: 30, null: false

      t.integer     :ordering, default: 1, null: false

      t.timestamps
    end
  end
end
