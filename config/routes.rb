Rails.application.routes.draw do
  # root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  # Defines the root path route ("/")
  # root "articles#index"
  root "landing#index"

  get "/locations/search", to: "locations#search"
  get "/third_spaces/search", to: "third_spaces#search"
  post "/third_spaces/favorite", to: "third_spaces#favorite"
  delete "/third_spaces/unfavorite", to: "third_spaces#unfavorite"
  get "/third_spaces/:id/edit", to: "third_spaces#edit"
  patch "/third_spaces/:id", to: "third_spaces#update"
  get "/third_spaces/:id/add_review", to: "third_spaces#add_review"
  patch "/third_spaces/:id/add_review", to: "third_spaces#save_review", as: "save_review_third_space"

  get "/third_spaces/:id/all_reviews", to: "third_spaces#all_reviews"

  resources :locations, only: [:index, :show, :new, :create]
  get '/locations/search', to: 'locations#search', as: 'location_search'
  
  get "/register", to: "users#new"
  post "/register", to: "users#create"
  get "/users/support", to: "users#support", as: 'support'
  get "/users/:id/recommendations/mood", to: "users#mood_recommendations_index", as: "mood_recommendations"
  get "/users/:id/recommendations", to: "users#loc_recommendations_index", as: "recommendations"
  get "/users/:id/saved_list", to: "users#saved_list", as: "user_saved_list"
  get "/users/:user_id", to: "users#show"
  get "/dashboard", to: "users#dashboard"
  get "/set_location", to: "users#set_location_form"

  get '/contact', to: 'contacts#new', as: :new_contact_form
  post '/contact', to: 'contacts#create'
  get '/privacy', to: 'users#privacy', as: 'privacy'

  get "/login", to: "users#login_form"
  post "/login", to: "users#login"

  get "/logout", to: "users#logout"

  get '/initiate_otp_verification', to: 'users#initiate_verification'
  post '/validate_otp', to: 'users#validate_otp'
  get '/validate_otp', to: 'users#validate_otp_form'

  resources :saved_locations, only: :index
  get '/search_locations/update', to: 'search_locations#update', as: :update_search_location
  resources :search_locations, only: [:create]

  resources :third_spaces do
    get :create_third_space, on: :collection, as: :create_third_space
  end

  resources :users, only: [] do
    resources :third_spaces, only: [:index], controller: 'users/third_spaces'
  end


  get '/user/auth/google_oauth2/callback', to: 'sessions#create'
  post '/geolocation_storage/lat_lon_session', to: 'geolocation_storage#lat_lon_session'

  get '/password/reset', to: 'password_resets#new'
  post '/password/reset', to: 'password_resets#create'
  get '/password/reset/edit', to: 'password_resets#edit'
  patch '/password/reset/edit', to: 'password_resets#update'

  namespace :admin do
    get "/dashboard", to: "dashboard#index"
  end
end
