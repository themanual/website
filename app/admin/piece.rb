ActiveAdmin.register Piece do

  permit_params :author_id, :issue_id, :title, :body, :synopsis, :illustrator, :position

  filter :author
  filter :issue
  filter :title
  filter :body
  filter :illustrator

  index do
  	id_column
  	column :type
  	column :author
  	column :title
  	column :illustrator
  	column :synopsis
  	column :position
  	default_actions
  end

  form do |f|

  	f.inputs "Meta" do
  		f.input :issue
  		f.input :author, input_html: { class: 'chosen-select' }
  		f.input :title
  		f.input :synopsis
  		f.input :illustrator
  		f.input :position

  		f.input :body, input_html: { class: 'editor-md' }

  		f.actions
  	end
  end

end
