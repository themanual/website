class IssuesController < ApplicationController

  before_action(only: [:index, :show]) { @nav = true }

  def index
    
  end

  def show
    issue_no = params[:number].to_i
    @issue = Issue.where(number: issue_no).first

    redirect_to read_path and return if @issue.nil? || !current_user.can?(:view, @issue)
    
    title "Issues"
    title @issue.name
    # @breadcrumb = true
    metadata "description", "#{@issue.name} of The Manual, with #{@issue.authors.map(&:name).to_sentence}."
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
