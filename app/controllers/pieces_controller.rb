class PiecesController < ApplicationController

  before_filter :check_access_to_issue, only: :show

  def show
    author = Author.fetch_by_uniq_key!(params[:key], :slug)
    @piece = Piece.includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, author_id: author.id).first

    metadata "og:type",         "article"
    metadata "og:title",        @piece.title
    metadata "description",     @piece.synopsis             if @piece.synopsis.present?
    metadata "og:description",  @piece.synopsis             if @piece.synopsis.present?
    metadata "twitter:creator", "@#{@piece.author.twitter}" if @piece.author.twitter.present?
    metadata "og:image",        view_context.image_url("#{@piece.illo_basepath}-square.jpg") if @piece.illustrator.present?

    render layout: "plain"
  end

end
