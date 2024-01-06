Rails.application.routes.draw do
  # root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root "landing#index"

  resources :locations, only: [:index, :show, :new, :create]
  get '/locations/search', to: 'locations#search', as: 'location_search'
  
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/users/:user_id", to: "users#show"

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  get "/logout", to: "users#logout"

  get '/initiate_otp_verification', to: 'users#initiate_verification'
  post '/validate_otp', to: 'users#validate_otp'
  get '/validate_otp', to: 'users#validate_otp_form'

end
