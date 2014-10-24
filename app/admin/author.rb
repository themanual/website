ActiveAdmin.register Author do

  menu parent: 'Editorial', priority: 1

  permit_params :name, :bio, :slug, :twitter

	filter :name
	filter :bio
	filter :articles

  index do
  	id_column
  	column :name
  	column :slug
  	column :twitter

  	actions
  end
end
