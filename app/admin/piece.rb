ActiveAdmin.register Piece do

  menu parent: 'Editorial', label: '⤷ Pieces', priority: 3

  permit_params :author_id, :issue_id, :title, :body, :synopsis, :illustrator, :position, :topic_list, :status, :type

  filter :issue
  filter :title
  filter :body
  filter :illustrator
  filter :staff_pick
  filter :topics

  index do
    id_column
    column :type
    column :author
    column :title
    column :synopsis
    column :position
    column :status
    column :staff_pick
    actions defaults: true do |piece|
      if piece.staff_pick?
        link_to('Unpick', unpick_admin_piece_path(piece))
      else
        link_to('Pick', pick_admin_piece_path(piece))
      end
    end
  end

  show do |ad|
    attributes_table do
      row :type
      row :author
      row :issue
      row :title
      row :synopsis
      row :topic_list, label: 'Topics'
    end
  end

  form do |f|

    f.inputs do
      f.input :issue
      f.input :type, as: :select, collection: ['Article', 'Lesson']
      f.input :author, input_html: { class: 'chosen-select' }
      f.input :title
      f.input :synopsis
      f.input :topic_list, label: 'Topics'
      f.input :illustrator
      f.input :position
      f.input :status, as: :select, collection: Piece.statuses.keys, include_blank: false

      f.input :body, input_html: { class: 'editor-md' }

    end
    f.actions
  end

  member_action :pick, :method => :get do
    piece = Piece.find(params[:id])
    piece.pick!
    redirect_to admin_pieces_path, notice: "Added to Staff Picks!"
  end

  member_action :unpick, :method => :get do
    piece = Piece.find(params[:id])
    piece.unpick!
    redirect_to admin_pieces_path, notice:"Removed to Staff Picks!"
  end

end