class AddMoreIndices < ActiveRecord::Migration
  def change
    add_index :issues, :number
    add_index :issues, :published_on

    add_index :shoppe_product_attributes, :product_id
    add_index :shoppe_product_attributes, [:key, :value]

    add_index :shoppe_products, :product_category_id
  end
end
