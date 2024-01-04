Rails.application.routes.draw do

  # Defines the root path route ("/")
  # root "articles#index"
  root "landing#index"

  resources :locations, only: [:index, :show]
  resources :users, only: [:show, :new, :create]

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  get "/logout", to: "users#logout"

end
