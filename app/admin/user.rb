ActiveAdmin.register User do

  menu parent: 'Readers', priority: 1

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
    column :shipping_address do |a|
      a.shipping_address.try(:name)
    end
  	# column :current_signin_at
  	# column :last_signin_at
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


  sidebar :shipping_address , :only => :show do
    ul do
      li {user.shipping_address.lines}
      li {user.shipping_address.city}
      li {user.shipping_address.region}
      li {user.shipping_address.post_code}
      li {user.shipping_address.country.name}
      li { link_to 'Edit', admin_address_path(user.shipping_address) }
    end
  end
end
