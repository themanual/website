class SeoController < ApplicationController

  # TODO uncomment when ready to go live
  # skip_before_filter :authenticate_user!

  before_filter :caching
  layout false

  def error_page
    title "Uh-oh"
    if params[:code] =~ /^[0-9]{3}$/
      render params[:code], layout: 'application', status: :not_found, formats: [:html]
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  private

    def caching
      expires_in 6.hours, :public => true, 'max-stale' => 0
    end
end
