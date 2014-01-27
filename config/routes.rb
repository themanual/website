TheManual::Application.routes.draw do

  root to: redirect("/issues")
  
  get '/issues', to: 'issues#index', as: :issues
  get '/issues/:issue', to: 'issues#show', as: :issue
  get '/issues/:issue/:key/:type', to: 'issues#piece', as: :piece

end
