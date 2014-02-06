ActiveAdmin.register User do

  permit_params :name, :email, :access_level

  filter :email
  filter :name
  filter :access_level
  filter :created_at

  index do
  	id_column
  	column :email
  	column :name
  	column :current_signin_at
  	column :last_signin_at
  	default_actions
  end
end
