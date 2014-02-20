class SwitchCountrySelectorToShoppeCountries < ActiveRecord::Migration
  def change
  	Address.delete_all
  	change_column :addresses, :country, :integer
  	rename_column :addresses, :country, :country_id
  end
end
