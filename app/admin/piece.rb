ActiveAdmin.register Piece do

  permit_params :author_id, :issue_id, :title, :body, :synopsis, :illustrator, :position

  filter :author
  filter :issue
  filter :title
  filter :body
  filter :illustrator
  filter :staff_pick

  index do
  	id_column
  	column :type
  	column :author
  	column :title
  	column :illustrator
  	column :synopsis
  	column :position
    column :staff_pick
  	actions defaults: true do |piece|
      if piece.staff_pick?
        link_to('Unpick', unpick_admin_piece_path(piece))
      else
        link_to('Pick', pick_admin_piece_path(piece))
      end
    end
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

  member_action :pick, :method => :get do
    piece = Piece.find(params[:id])
    piece.update_attributes staff_pick: true, staff_pick_at: Time.now
    redirect_to admin_pieces_path, notice: "Added to Staff Picks!"
  end

  member_action :unpick, :method => :get do
    piece = Piece.find(params[:id])
    piece.update_attributes staff_pick: false, staff_pick_at: nil
    redirect_to admin_pieces_path, notice:"Removed to Staff Picks!"
  end

end
