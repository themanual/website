class TopicsController < ApplicationController
  def show
    @pieces = Piece.tagged_with(params[:topic]).joins(:issue).where(issue: current_user.visible_issues).order('issues.number DESC, pieces.position ASC')
    @breadcrumb = true
    
    title    "Topics"
    title    params[:topic].titlecase
    metadata "og:title", "Topic: #{params[:topic].titlecase}"
    metadata "description", "The Manual’s #{@pieces.size} #{'piece'.pluralize(@pieces.size)} on #{params[:topic].titlecase}."

    redirect_to read_path if @pieces.blank?
  end
end
