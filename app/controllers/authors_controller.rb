class AuthorsController < ApplicationController
  
  before_action { title "Authors" }
  
  def index
    @authors = Author.includes(:pieces => :issue).order(:name)
  end

  def show
    @author = Author.where(slug: params[:slug]).includes(:pieces => :issue).first
  end
end
