class PiecesController < ApplicationController

  def index
    @issues = Issue.published.ordered.includes(:pieces => :author).order('pieces.position DESC, pieces.type DESC')
    respond_to do |format|
      format.html { redirect_to read_path }
      format.rss  { render layout: false }
    end
  end

  def staffpicks
    @sidebar = true
    @pieces = Piece.staff_picks
    title "Staff Picks"
    metadata "og:title", "Staff Picks"
    metadata "description",     "A selection of #{@pieces.count} pieces picked by The Manual’s staff."
  end

  def show
    begin
      @author = Author.fetch_by_uniq_key!(params[:key], :slug)
      @piece  = Piece.includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, author_id: @author.id).first
      @issue  = @piece.issue
    rescue ActiveRecord::RecordNotFound
      redirect_to read_path and return
    end

    redirect_to read_path and return unless current_user.can?(:view, @issue)

    title    "#{@piece.title}, by #{@author.name}"
    metadata "og:type",         "article"
    metadata "og:title",        @piece.freestanding_title
    metadata "description",     @piece.synopsis if @piece.synopsis.present?
    metadata "twitter:creator", "@#{@author.twitter}" if @author.twitter.present?
    metadata "og:image",        view_context.image_url("#{@piece.illo_basepath}-square.jpg") if @piece.illustrator.present?

    render layout: "plain"
  end

end
