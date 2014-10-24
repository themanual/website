class IssuesController < ApplicationController

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
      @issue = Issue.where(number: issue_no).first

      if @issue.nil? or @issue.unpublished? or !current_user.can_view? @issue
        redirect_to read_path and return
      end

      metadata "og:title",        "Issue #{@issue.number}"
      metadata "description",     "Issue #{@issue.number} of The Manual, with #{@issue.authors.map(&:name).to_sentence}."
    end
  end

  def download
    if current_user.anon?
      redirect_to login_path
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
