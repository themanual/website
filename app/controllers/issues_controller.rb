class IssuesController < ApplicationController

  # skip_before_filter :authenticate_user!
  before_filter :check_access_to_issue, only: :show

  def index
    redirect_to read_path
  end

  def show
    issue_no = params[:issue].to_i
    if issue_no == 4
      metadata "og:title",        "Issue 4"
      metadata "description",     "Issue of The Manual is coming soon. Featuring Jeniffer Brook, David Cole, Paul Ford, Diana Kimball, Wilson Miner, and Craig Mod."
      render :soon
    else
      # TODO: Ensure only visible issues can be seen (public, or purchased by current user)
      @issue = Issue.published.public_access.where(number: issue_no).first
      redirect_to read_path and return unless @issue

      metadata "og:title",        "Issue #{@issue.number}"
      metadata "description",     "Issue #{@issue.number} of The Manual, with #{@issue.authors.map(&:name).to_sentence}."
    end
  end

  def download
    if current_user.anon?
      redirect_to new_user_session_path
    else
      dl = Download.find params[:dl] # will raise ActiveRecord::RecordNotFound if doesn't exist

      ownership = Ownership.where(user_id: current_user.id, issue_id: dl.issue_id).first

      # user doesn't own it
      raise ActiveRecord::RecordNotFound and return unless ownership.present?

      if ownership.can_access? dl.medium.downcase
        redirect_to dl.url
      else
        # ownership/subscription doesn't give access to this file
        raise ActiveRecord::RecordNotFound
      end

    end
  end

end
