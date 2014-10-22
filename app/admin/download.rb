ActiveAdmin.register Download do
  config.sort_order = 'ordering_asc'

  permit_params :issue_id, :medium, :format, :ordering, :file

  filter :issue
  filter :medium

  index do
    id_column
    column :issue
    column :medium
    column :format
    column :file_file_size do |d|
      number_to_human_size d.file_file_size
    end
    column :ordering

    actions defaults: true do |dl|
      link_to('Download', dl_admin_download_path(dl))
    end
  end

  form do |f|

    f.inputs do
      f.input :issue
      f.input :medium
      f.input :format

      f.input :file

    end
    f.actions
  end

  member_action :dl, :method => :get do
    dl = Download.find(params[:id])
    redirect_to dl.url
  end

end
