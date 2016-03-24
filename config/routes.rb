TheManual::Application.routes.draw do

  ActiveAdmin.routes(self)
  mount Shoppe::Engine => "/shoppe"

  root to: redirect('/read'), as: :root

  get '/issue1', to: redirect('/read/issues/1')
  get '/issue2', to: redirect('/read/issues/2')
  get '/issue3', to: redirect('/read/issues/3')
  get '/issue4', to: redirect('/read/issues/4')

  scope '/read' do
    get '/', to: 'pieces#staffpicks', as: :read
    resources :authors, only: [:index, :show], param: :slug
    resources :topics,  only: [:index, :show], param: :topic
    resources :issues,  only: [:index, :show], param: :number
    get '/issues/:issue/:key/:type',  to: 'pieces#show', as: :piece, constraints: {type: /(lesson|article)/}
  end

  # ABOUT
  get '/about(/:action)', controller: :about, as: :about

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
