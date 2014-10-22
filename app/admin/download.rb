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

    actions
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

end
