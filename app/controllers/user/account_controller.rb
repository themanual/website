class User::AccountController < ApplicationController
  before_filter :authenticate_user!
  def show
    @downloads = current_user.issues_with_downloads
  end
end
