ActiveAdmin.register Ownership do

  menu parent: 'Readers'

  permit_params :user_id, :issue_id, :level, :subscription_id

  filter :issue
  filter :shipped
  filter :level, as: :select, collection: Ownership::LEVELS.keys, include_blank: true

  controller do
    def scoped_collection
      Ownership.includes(:subscription, :user, :issue)
    end
  end

  index do
    id_column
    column :user
    column :issue
    column :level, as: :select, collection: Ownership::LEVELS.keys, include_blank: false

    actions
  end

  form do |f|

    f.inputs do
      f.input :user, input_html: { class: 'chosen-select' }
      f.input :issue
      f.input :level, as: :select, collection: Ownership::LEVELS.keys, include_blank: false
    end
    f.actions
  end

end
