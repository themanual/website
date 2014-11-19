class User::AccountController < ApplicationController
  before_filter :authenticate_user!
  def show

    @visible_downloads = {}

    issues_with_downloads = current_user.issues_with_downloads

    issues_with_downloads.each do |issue|
      issue_downloads = []

      issue.downloads.each do |dl|
        if issue.ownerships.where(user_id: current_user.id).any? {|o| o.can_access? dl.medium.downcase }
          issue_downloads << dl
        end
      end

      if issue_downloads.size > 0
        @visible_downloads[issue.number] = issue_downloads
      end
    end
  end
end
