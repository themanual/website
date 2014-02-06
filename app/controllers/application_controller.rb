class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_order, :has_order?, :push_page_title
  before_filter :prep_page_title

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

    def current_order
      @current_order ||= begin
        if has_order?
          @current_order
        else
          order = Shoppe::Order.create(:ip_address => request.ip)
          session[:order_id] = order.id
          order
        end
      end
    end

    def has_order?
      !!(
        session[:order_id] &&
        @current_order = Shoppe::Order.includes(:order_items => :ordered_item).find_by_id(session[:order_id])
      )
    end

    def push_page_title title
      ( @page_title << title ).flatten!
    end
    def prep_page_title; @page_title ||= []; end
end
