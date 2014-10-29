class LoosenAddressValidation < ActiveRecord::Migration
  def change
    change_column :addresses,  :region, :string, limit: 128, null: true
    change_column :addresses,  :post_code, :string, limit: 32, null: true
  end
end
