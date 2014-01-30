TheManual::Application.routes.draw do

  devise_for :users,
  					 :skip => [:password, :sessions, :registrations],
	           :path => ''


	as :user do
    get 'login/:token'  => 'sessions#create',   :as => :login_token
    get 'login'         => 'sessions#new',      :as => :new_user_session
    get 'logout'        => 'sessions#destroy',  :as => :destroy_user_session
    post 'login'        => 'sessions#create',   :as => :user_session
    # get 'account' => 'devise/registrations#edit', :as => :edit_user_registration
    # put 'account' => 'devise/registrations#update'
  end




  root to: redirect("/issues")

  get '/issues', to: 'issues#index', as: :issues
  get '/issues/:issue', to: 'issues#show', as: :issue
  get '/issues/:issue/:key/:type', to: 'issues#piece', as: :piece

  get '/blog', to: redirect("http://blog.alwaysreadthemanual.com")

end
