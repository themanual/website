class IssuesController < ApplicationController

  def index
    redirect_to read_path
  end

  def show
    issue_no = params[:issue].to_i
    @issue = Issue.where(number: issue_no).first

    if @issue.number == 4 && @issue.unpublished? && !current_user.can?(:view, @issue)
      metadata "og:title",        "Issue 4"
      metadata "description",     "Issue of The Manual is coming soon. Featuring Jeniffer Brook, David Cole, Paul Ford, Diana Kimball, Wilson Miner, and Craig Mod."
      render :soon
    else
      redirect_to read_path and return if @issue.nil? || !current_user.can?(:view, @issue)
      metadata "og:title",        @issue.name
      metadata "description",     "#{@issue.name} of The Manual, with #{@issue.authors.map(&:name).to_sentence}."
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
