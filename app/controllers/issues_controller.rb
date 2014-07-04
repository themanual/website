class IssuesController < ApplicationController

  # skip_before_filter :authenticate_user!
  before_filter :check_access_to_issue, only: [:show, :piece]

  def index
    render layout: "reading"
  end

  def show
    # TODO: Ensure only visible issues can be seen (public, or purchased by current user)
    @issue = Issue.where(number: params[:issue].to_i).first

    redirect_to issues_url unless @issue

    render layout: "reading"
  end

  def piece

    author = Author.fetch_by_uniq_key!(params[:key], :slug)

    @piece = Piece.includes(:author, :issue).where(issue_id: params[:issue].to_i, type: params['type'].titleize, author_id: author.id).first

    redirect_to issues_url unless @piece
  end

  protected

    def check_access_to_issue
      true
      # TODO: allow for public issues, check users purchase history for non-public
    end
end
