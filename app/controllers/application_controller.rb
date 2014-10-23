class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_order, :has_order?, :title, :metadata

  # TODO move this elsewhere https://github.com/themanual/website/issues/19
  # before_filter :authenticate_user!

  before_filter :authorise_profiler

  before_filter :store_path

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

    def title page_title = nil, options = {}
      options.reverse_merge!({:method => 'unshift'})
      @page_title ||= []
      if page_title.present?
        @page_title.send(options[:method], page_title).flatten!
        if options[:pre_title]
          @pre_title = true
          logger.debug "adding pre_title of #{page_title}"
        end
      end
      @page_title
    end

    def metadata key = nil, value = nil
      @page_metadata ||= {
        "og:title"        => "The Manual",
        "twitter:site"    => "@themanual",
        "twitter:card"    => "summary",
        "description"     => "The Manual is a design journal for the web.",
        "og:description"  => "The Manual is a design journal for the web.",
        "og:site_name"    => "The Manual",
        "og:url" => request.url
      }
      @page_metadata[key] = value         if key.present? && value.present?
      @page_metadata["og:#{key}"] = value if key.present? && value.present? && key.in?(%w(description))
      @page_metadata
    end

    def check_access_to_issue
      true
      # TODO: allow for public issues, check users purchase history for non-public
    end

    def store_path
      if current_user.anon?
        session[:return_to] = request.path
      else
        session[:return_to] = nil
      end
    end

    def authorise_profiler
      if current_user.access_level > 0
        Rack::MiniProfiler.authorize_request
      end
    end

end
