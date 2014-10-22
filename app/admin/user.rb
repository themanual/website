ActiveAdmin.register User do

  permit_params :first_name, :last_name, :email, :access_level

  filter :email
  filter :first_name
  filter :last_name
  filter :access_level
  filter :created_at

  index do
  	id_column
  	column :email
    column :first_name
  	column :last_name
  	column :current_signin_at
  	column :last_signin_at
  	actions
  end

  form do |f|

    f.inputs do
      f.input :email
      f.input :access_level
      f.input :first_name
      f.input :last_name
    end
    f.actions
  end
end
