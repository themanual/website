class AddPortraitIllustration < ActiveRecord::Migration
  def change
    add_column :issues, :portrait_illustrator, :string, default: '', null: false
  end
end
