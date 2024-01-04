Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "landing#index"

  resources :locations, only: [:index, :show]
  resources :users, only: [:show, :new, :create]

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  get "/logout", to: "users#logout"

  resources :user_mfa_sessions, only: [:new, :create]
end
