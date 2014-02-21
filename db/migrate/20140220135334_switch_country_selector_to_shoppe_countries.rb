class SwitchCountrySelectorToShoppeCountries < ActiveRecord::Migration
  def change
  	Address.delete_all
  	remove_column :addresses, :country
  	add_column :addresses, :country_id, :integer, null: false, default: 0
  end
end
