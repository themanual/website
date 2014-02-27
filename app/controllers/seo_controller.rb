class SeoController < ApplicationController

  # TODO uncomment when ready to go live
  # skip_before_filter :authenticate_user!

  before_filter :caching
  layout false

  private

    def caching
      expires_in 6.hours, :public => true, 'max-stale' => 0
    end
end
