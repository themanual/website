TheManual::Application.routes.draw do

  ActiveAdmin.routes(self)
  mount Shoppe::Engine => "/shoppe"

  devise_for :users,
             :skip => [:password, :sessions, :registrations],
             :path => ''

  root to: 'home#index'

  as :user do
    get 'login/:token'  => 'sessions#create',   :as => :login_token
    get 'login'         => 'sessions#new',      :as => :new_user_session # TODO rename to "login" ?
    get 'logout'        => 'sessions#destroy',  :as => :destroy_user_session
    post 'login'        => 'sessions#create',   :as => :user_session
  end

  resource :account, controller: 'user/account', only: [:show, :update] do
    resources :emails, controller: 'user/emails', only: [:create, :destroy, :update]
    resources :addresses, controller: 'user/addresses', only: [:create, :destroy, :update]
  end

  # READ
  scope '/read' do
    root                              to: redirect('/read/staffpicks'),                     as: :read
    get '/issues',                    to: 'issues#index',                                   as: :issues
    get '/issues/:issue',             to: 'issues#show',                                    as: :issue
    get '/issues/:issue/:key/:type',  to: 'pieces#show',                                    as: :piece
    get '/staffpicks',                to: 'pieces#staffpicks',                              as: :staffpicks
    get '/popular',                   to: 'pieces#popular',                                 as: :popular
    get '/topics/:topic',             to: 'pieces#index',                                   as: :topic
    get '/blog',                      to: redirect("http://blog.alwaysreadthemanual.com"),  as: :blog
  end

  # STORE
  get '/store',              to: 'store#index',        as: :shop
  get '/store/issues',       to: 'store#issues',       as: :shop_issues
  get '/store/subscription', to: 'store#subscription', as: :shop_subscription
  get '/store/issue/:issue', to: 'store#issue',        as: :shop_issue

  # ABOUT
  get '/about', to: 'about#index',  as: :about

  # Payment / Legacy
  # resource :subscribe, controller: :support, only: [:show, :create] do
  #   get ':tier/thanks',   action: :thanks,   as: :thanks
  #   get ':tier/checkout', action: :checkout, as: :checkout
  # end

  # post  '/buy/:permalink',          to: 'orders#update',    as: :purchase
  # get   '/checkout',                to: 'orders#show',      as: :basket
  get   '/shipping_estimate',       to: 'home#shipping_estimate', as: :shipping
  # get   '/cart',  to: 'home#cart',    as: :cart

  # SEO & errors
  get "robots(.:format)" => 'seo#robots'
  get "sitemap(.:format)" => 'seo#sitemap'
  get "errors/:code" => 'seo#error_page', contraints: {code: /[0-9]{3}/}

  # DEFAULT
  get ':controller(/:action(/:id))'
end
