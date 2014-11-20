ActiveAdmin.register Address do

  actions :all, except: [:destroy]

  menu parent: 'Readers', priority: 2


  permit_params :lines, :city, :region, :post_code, :country_id, :user_id

  filter :country

  index do
    id_column
    column :user
    column :lines
    column :city
    column :region
    column :post_code
    column :country
    column :created_at

    actions
  end

  form do |f|

    f.inputs (resource.new_record? ? nil : "Update address for #{resource.user.name}") do
      f.input :user_id, as: :hidden
      f.input :lines
      f.input :city
      f.input :region
      f.input :post_code
      f.input :country, input_html: { class: 'chosen-select' }
    end
    f.actions
  end


  controller do
    def create
      super

      resource.user.update_attribute(:shipping_address_id, resource.id)
    end
    def update

      address = resource.dup
      address.attributes = permitted_params[:address]

      save_resource address

      address.user.update_attribute(:shipping_address_id, address.id)

      redirect_to collection_path
    end
  end


end
