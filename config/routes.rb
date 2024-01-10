Rails.application.routes.draw do
  # root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root "landing#index"

  get "/locations/search", to: "locations#search"
  post "/third_spaces/search", to: "third_spaces#search"

  resources :locations, only: [:index, :show, :new, :create]
  get '/locations/search', to: 'locations#search', as: 'location_search'
  
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/users/support", to: "users#support", as: 'support'
  get "/users/:user_id", to: "users#show"
  get "/dashboard", to: "users#dashboard"
  get "/set_location", to: "users#set_location_form"

  get '/contact', to: 'contacts#new', as: :new_contact_form
  post '/contact', to: 'contacts#create'

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  get "/logout", to: "users#logout"

  get '/initiate_otp_verification', to: 'users#initiate_verification'
  post '/validate_otp', to: 'users#validate_otp'
  get '/validate_otp', to: 'users#validate_otp_form'

  resources :saved_locations, only: :index
  resources :search_locations, only: :create

  resources :third_spaces, only: [:new, :create, :index] do
    get :create_third_space, on: :collection, as: :create_third_space
  end


  get '/user/auth/google_oauth2/callback', to: 'sessions#create'
  post '/geolocation_storage/lat_lon_session', to: 'geolocation_storage#lat_lon_session'
end
