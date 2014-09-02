class IssuesController < ApplicationController

  # skip_before_filter :authenticate_user!
  before_filter :check_access_to_issue, only: :show

  def index
  end

  def show
    # TODO: Ensure only visible issues can be seen (public, or purchased by current user)
    @issue = Issue.where(number: params[:issue].to_i).first

    redirect_to read_path unless @issue && @issue.published?
  end

end
