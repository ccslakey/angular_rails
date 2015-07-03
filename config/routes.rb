Rails.application.routes.draw do

  root to: "sites#home"

  get "/signup", to: "store_owners#new", as: "new_store"
  
  get "/account", to: "store_owners#show", as: "store_owners"
  post "/account", to: "store_owners#create"
  
  get "/login", to: "sessions#new", as: "login"
  post "/login", to: "sessions#create"

  
  post "/account/token_reset", to: "store_owners#token_reset"
  delete 'logout', to: 'sessions#destroy'
end
