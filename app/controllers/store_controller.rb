class StoreController < ApplicationController

  layout "store"

  def index
    redirect_to :action => 'featured'
  end

  def featured
  end

  def subscription
  end

  def issues
  end

end