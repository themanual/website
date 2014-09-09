class TopicsController < ApplicationController
  def show
    @pieces = Piece.tagged_with(params[:topic])

    title    "Topic: #{params[:topic].titlecase}"
    metadata "og:title", "Topic: #{params[:topic].titlecase}"
    metadata "description", "The Manual’s #{@pieces.count} #{'piece'.pluralize(@pieces.count)} on #{params[:topic].titlecase}."

    redirect_to read_path if @pieces.blank?
  end
end
