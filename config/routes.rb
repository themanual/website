TheManual::Application.routes.draw do

  ActiveAdmin.routes(self)
  mount Shoppe::Engine => "/shoppe"

  devise_for :users,
             :skip => [:password, :sessions, :registrations],
             :path => ''

  root to: 'home#index'
  get '/feed', to: 'pieces#index', defaults: {format: 'rss'}, :as => :feed

  as :user do
    get 'login/:token'  => 'sessions#create',   :as => :login_token
    get 'login'         => 'sessions#new',      :as => :new_user_session # TODO rename to "login" ?
    get 'logout'        => 'sessions#destroy',  :as => :destroy_user_session
    post 'login'        => 'sessions#create',   :as => :user_session
  end

  resource :account, controller: 'user/account', only: [:show, :update] do
    resources :emails, controller: 'user/emails', only: [:create, :destroy, :update]
    resources :addresses, controller: 'user/addresses', only: [:index, :create, :destroy, :update]
  end

  # READ
  scope '/read' do
    root                              to: redirect('/read/staffpicks'),                     as: :read
    get '/issues',                    to: 'issues#index',                                   as: :issues
    get '/issues/:issue',             to: 'issues#show',                                    as: :issue
    get '/issues/:issue/:key/:type',  to: 'pieces#show',                                    as: :piece
    get '/staffpicks',                to: 'pieces#staffpicks',                              as: :staffpicks
    get '/topics',                    to: redirect('/read')
    get '/topics/:topic',             to: 'topics#show',                                    as: :topic
    get '/blog',                      to: redirect("http://blog.themanual.org"),  as: :blog
  end

  get '/blog', to: redirect("http://blog.themanual.org")
  get '/twitter', to: redirect("https://twitter.com/themanual"), as: :twitter

  # STORE
  # get '/store',              to: 'store#index',        as: :shop
  # get '/store/issues',       to: 'store#issues',       as: :shop_issues
  # get '/store/subscription', to: 'store#subscription', as: :shop_subscription
  # get '/store/issue/:issue', to: 'store#issue',        as: :shop_issue
  get '/shop',                  to: redirect("http://shop.themanual.org"),                      as: :shop
  get '/shop/product/:product', to: redirect("http://shop.themanual.org/products/%{product}"),  as: :shop_product
  get '/store',                 to: redirect("/shop")

  # ABOUT
  get '/about', to: 'about#index',  as: :about

  get '/kickstarter',            to: redirect('/kickstarter/everywhere'),                                                 as: :kickstarter
  get '/kickstarter/original',   to: redirect('https://www.kickstarter.com/projects/goodonpaper/the-manual'),             as: :ks_original
  get '/kickstarter/everywhere', to: redirect('https://www.kickstarter.com/projects/goodonpaper/the-manual-everywhere'),  as: :ks_everywhere

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
  get "errors/:code" => 'seo#error_page', constraints: {code: /[0-9]{3}/}

  # DEFAULT
  get ':controller(/:action(/:id))'
end
