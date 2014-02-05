class AddShoppeProducts < ActiveRecord::Migration
  def change

  	cat = Shoppe::ProductCategory.create name: 'The Manual', permalink: 'the-manual'


  	[1,2,3].each do |i|

  		name = "Issue ##{i}"
  		parent = Shoppe::Product.create sku: "ISSUE00#{i}", name: name, permalink: "issue-#{i}", description: name, short_description: name, product_category_id: cat.id, stock_control: false

  		digital = Shoppe::Product.create sku: "ISSUE00#{i}DIG", name: 'Digital', permalink: "issue-#{i}-digital", description: name, short_description: name, product_category_id: cat.id, parent_id: parent.id, stock_control: false, price: 10

  		print = Shoppe::Product.create sku: "ISSUE00#{i}PRN", name: 'Print', permalink: "issue-#{i}-print", description: name, short_description: name, product_category_id: cat.id, parent_id: parent.id, stock_control: false, price: 25

  		Issue.where(number: i).update_all(shoppe_permalink: print.permalink, shoppe_permalink_digital: digital.permalink)
  	end
  end
end
