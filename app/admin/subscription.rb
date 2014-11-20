ActiveAdmin.register Subscription do

  menu parent: 'Readers'

  permit_params :user_id, :start_date, :start_issue, :issues_duration, :issues_remaining, :level, :status

  filter :status, as: :select, collection: Subscription.statuses.keys, include_blank: false
  filter :level, as: :select, collection: Ownership::LEVELS.keys, include_blank: false

  index do
    id_column
    column :user
    column :start_date
    column :start_issue
    column :issues_duration
    column :issues_remaining
    column :level

    actions
  end

  form do |f|

    f.inputs do
      f.input :user, input_html: { class: 'chosen-select' }
      f.input :start_date
      f.input :start_issue
      f.input :issues_duration
      f.input :issues_remaining
      f.input :level, as: :select, collection: Ownership::LEVELS.keys, include_blank: false
      f.input :status, as: :select, collection: Subscription.statuses.keys, include_blank: false
    end
    f.actions
  end

  sidebar :ownerships, only: :show do

    table_for subscription.ownerships do
      column :issue do |ownership|
        ownership.issue.number
      end
      column :level
      column '' do |ownership|
        link_to('View', admin_ownership_path(ownership))
      end
      column '' do |ownership|
        link_to('Edit', edit_admin_ownership_path(ownership))
      end
    end

    render('admin/subscriptions/new_ownership', {subscription: subscription})

  end

end
