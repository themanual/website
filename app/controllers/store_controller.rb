class StoreController < ApplicationController

  before_action { title "Shop" }

  def index
  end

  def subscription
  end

  def issues

  end

  def issue
    @issue = Issue.where(number: params[:issue].to_i).first
  end

end