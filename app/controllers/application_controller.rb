class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  protected
  	def authenticate_admin_user!
  		redirect_to new_user_session_path unless current_user.access_level > 0
  	end

  	def user_signed_in?
      !current_user.anon?
    end

    def current_user
      @current_user ||= begin
      	warden.authenticate(:scope => :user) || User.anon_user
      end
    end

end
