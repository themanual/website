TheManual::Application.routes.draw do

  ActiveAdmin.routes(self)
  mount Shoppe::Engine => "/shoppe"

  devise_for :users,
             :skip => [:password, :sessions, :registrations],
             :path => ''


  as :user do
    get 'login/:token'  => 'sessions#create',   :as => :login_token
    get 'login'         => 'sessions#new',      :as => :new_user_session
    get 'logout'        => 'sessions#destroy',  :as => :destroy_user_session
    post 'login'        => 'sessions#create',   :as => :user_session
  end

  resource :account, controller: 'user/account', only: [:show, :update] do
    resources :emails, controller: 'user/emails', only: [:create, :destroy, :update]
    resources :addresses, controller: 'user/addresses', only: [:create, :destroy, :update]
  end

  root to: redirect("/issues")

  resource :support, controller: :support, only: [:show, :create] do
    get :thanks
    get 'checkout/:tier', action: :checkout, as: :checkout
  end

  get '/issues',                    to: 'issues#index',     as: :issues
  get '/issues/:issue',             to: 'issues#show',      as: :issue
  get '/issues/:issue/:key/:type',  to: 'issues#piece',     as: :piece

  post  '/buy/:permalink',          to: 'orders#update',    as: :purchase
  get   '/checkout',                to: 'orders#show',      as: :basket

  # TODO move this somewhere sensible
  get   '/shipping_estimate',       to: 'home#shipping_estimate', as: :shipping

  get '/blog', to: redirect("http://blog.alwaysreadthemanual.com")

  # seo stuff
  get "robots(.:format)" => 'seo#robots'
  get "sitemap(.:format)" => 'seo#sitemap'
end
