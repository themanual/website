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

end
