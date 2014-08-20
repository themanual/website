class PiecesController < ApplicationController

  before_filter :check_access_to_issue, only: :show

  def show

    author = Author.fetch_by_uniq_key!(params[:key], :slug)

    @piece = Piece.includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, author_id: author.id).first

    render layout: "plain"
  end

end
