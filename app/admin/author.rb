ActiveAdmin.register Author do

  permit_params :name, :bio, :slug, :twitter

	filter :name
	filter :bio
	filter :articles

  index do
  	id_column
  	column :name
  	column :slug
  	column :twitter

  	default_actions
  end
end
