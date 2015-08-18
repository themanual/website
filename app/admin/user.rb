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

  action_item :login_as, only: :show do
    link_to "Login as #{user.first_name}", new_user_session_path(admin_token: user.generate_admin_login_token)
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
    if user.shipping_address_id.present?
      h4  user.shipping_address.name
      p link_to 'Edit Address', edit_admin_address_path(user.shipping_address)
    else
      h4 "No Shipping Address"
      p link_to 'Add one', new_admin_address_path('address[user_id]' => user.id)
    end
  end

  sidebar :subscriptions, only: :show do

    table_for user.subscriptions do
      column :start_issue
      column :level
      column :status
      column '' do |subscription|
        link_to('View', admin_subscription_path(subscription))
      end
      column '' do |subscription|
        link_to('Edit', edit_admin_subscription_path(subscription))
      end
    end

  end
end
