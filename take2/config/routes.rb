Rails.application.routes.draw do

  root 'site#index'

  get '/signup', to: 'stores#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  post '/stores', to: 'stores#create'
  post "/account/token_reset", to: "store_owners#token_reset"
  
  get '/account/:id', to: 'stores#show', as: 'account'

  get '/receipts', to: 'receipts#show', as: 'receipts'
  post '/receipts', to: 'receipts#create'

  # this route is necessary for using respond_with
  get '/receipt/:id', to: 'receipts#show', as: 'receipt'

  get '/passwd_reset', to: 'stores#passwd_reset', as: 'passwd_reset'

end
