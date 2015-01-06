TheManual::Application.routes.draw do

  ActiveAdmin.routes(self)
  mount Shoppe::Engine => "/shoppe"

  root to: 'pieces#staffpicks', as: :root
  resources :authors, only: [:index, :show], param: :slug
  resources :topics,  only: [:index, :show], param: :topic
  resources :issues,  only: [:index, :show], param: :number
  get '/issues/:issue/:key/:type',  to: 'pieces#show', as: :piece, constraints: {type: /(lesson|article)/}

  # OLD ROUTES
  get '/read',        to: redirect("/"), as: :read
  get '/staffpicks',  to: redirect('/'), as: :staffpicks
  get '/read/*other', to: redirect { |path_params| "/#{path_params[:other]}" }

  # ABOUT
  get '/about', to: 'about#index',  as: :about
  get '/about(/:action)', controller: :about

  get '/download/:dl', to: 'issues#download', as: :download

  get '/blog',                    to: redirect("http://blog.themanual.org"),      as: :blog
  get '/twitter',                 to: redirect("https://twitter.com/themanual"),  as: :twitter
  get '/shop',                    to: redirect("http://shop.themanual.org"),                      as: :shop
  get '/shop/product/:product',   to: redirect("http://shop.themanual.org/products/%{product}"),  as: :shop_product
  get '/store',                   to: redirect("/shop")
  get '/kickstarter',             to: redirect('/kickstarter/everywhere'),                                                 as: :kickstarter
  get '/kickstarter/original',    to: redirect('https://www.kickstarter.com/projects/goodonpaper/the-manual'),             as: :ks_original
  get '/kickstarter/everywhere',  to: redirect('https://www.kickstarter.com/projects/goodonpaper/the-manual-everywhere'),  as: :ks_everywhere
  
  get '/feed', to: 'pieces#index', defaults: {format: 'rss'}, :as => :feed

  devise_for :users,
             :skip => [:password, :sessions, :registrations],
             :path => ''

  as :user do
    get 'login/:token'  => 'sessions#create',   :as => :login_token
    get 'login'         => 'sessions#new',      :as => :new_user_session # TODO rename to "login" ?
    get 'logout'        => 'sessions#destroy',  :as => :destroy_user_session
    post 'login'        => 'sessions#create',   :as => :user_session
  end

  resource :account, controller: 'user/account', only: [:show, :update, :edit] do
    resources :emails, controller: 'user/emails', only: [:create, :destroy, :update]
    resource  :address, controller: 'user/addresses', only: [:show, :create]
  end

  # Payment / Legacy
  # resource :subscribe, controller: :support, only: [:show, :create] do
  #   get ':tier/thanks',   action: :thanks,   as: :thanks
  #   get ':tier/checkout', action: :checkout, as: :checkout
  # end

  # post  '/buy/:permalink',          to: 'orders#update',    as: :purchase
  # get   '/checkout',                to: 'orders#show',      as: :basket
  get '/shipping_estimate',       to: 'home#shipping_estimate', as: :shipping
  get '/geoip',                   to: 'home#geoip',             as: :geoip
  # get   '/cart',  to: 'home#cart',    as: :cart

  # SEO & errors
  get "robots(.:format)" => 'seo#robots'
  get "sitemap(.:format)" => 'seo#sitemap'
  get "errors/:code" => 'seo#error_page', constraints: {code: /[0-9]{3}/}
  match '*path', via: :get, to: 'seo#error_page', defaults: {code: '404'} # nicely handle 404s, no stacktraces now
end
