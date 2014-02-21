class SwitchProductSlugsToIds < ActiveRecord::Migration
  def change
  	add_column	:issues, :shoppe_digital_id, :integer, null: true
  	add_column	:issues, :shoppe_id, :integer, null: true

  	remove_column :issues, :shoppe_permalink_digital
  	remove_column :issues, :shoppe_permalink
  end
end
