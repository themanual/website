class PiecesController < ApplicationController

  before_filter :check_access_to_issue, only: :show

  def staffpicks
    @pieces = Piece.staff_picks

    title    "Staff Picks"
    metadata "og:title", "Staff Picks"
    metadata "description",     "A selection of #{@pieces.count} pieces picked by The Manual’s staff."
  end

  def popular
  end

  def index
    @pieces = Piece.tagged_with(params[:topic])

    title    "Topic: #{params[:topic].titlecase}"
    metadata "og:title", "Topic: #{params[:topic].titlecase}"
    metadata "description", "The Manual’s #{@pieces.count} #{'piece'.pluralize(@pieces.count)} on #{params[:topic].titlecase}."

    redirect_to read_path unless @pieces.any?
  end

  def show
    author = Author.fetch_by_uniq_key!(params[:key], :slug)
    @piece = Piece.includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, author_id: author.id).first

    title    "#{@piece.title}, by #{@piece.author.name}"
    metadata "og:type",         "article"
    metadata "og:title",       (@piece.lesson? ? "#{@piece.author.name.possessive} #{@piece.type}" : @piece.title)
    metadata "description",     @piece.synopsis             if @piece.synopsis.present?
    metadata "twitter:creator", "@#{@piece.author.twitter}" if @piece.author.twitter.present?
    metadata "og:image",        view_context.image_url("#{@piece.illo_basepath}-square.jpg") if @piece.illustrator.present?

    render layout: "plain"
  end

end
