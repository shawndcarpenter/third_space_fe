Rails.application.config.middleware.use OmniAuth::Builder do
  google_credentials = Rails.application.credentials.google

  provider :google_oauth2, google_credentials[:client_id], google_credentials[:client_secret], redirect_uri: 'http://127.0.0.1:5000/user/auth/google_oauth2/callback'
end
OmniAuth.config.allowed_request_methods = %i[get]