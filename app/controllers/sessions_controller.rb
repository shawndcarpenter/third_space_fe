class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    #binding.pry
    if auth.present? && auth['provider'].present? && auth['uid'].present? && auth['info'].present?
      user = User.find_by(email: auth['info']['email'])
      # user = User.find_or_create_by(email: auth['info']['email']) do |u|
      #   u.first_name = auth['info']['first_name']
      #   u.last_name = auth['info']['last_name']
      #   u.email = auth['info']['email']
      # end
      #binding.pry
      if user.present?
        # User already exists, handle accordingly (e.g., update user details)
        #binding.pry
        session[:user_id] = user.id
        redirect_to set_location_path
      else
        new_user = User.new(
          email: auth['info']['email'],
          first_name: auth['info']['first_name'],
          last_name: auth['info']['last_name'],
          provider: true
        )

        if new_user.save
          session[:user_id] = new_user.id
          redirect_to set_location_path
        else
          Rails.logger.error("Validation errors: #{new_user.errors.full_messages.join(', ')}")
          flash[:error] = 'User creation failed due to validation errors.'
          redirect_to root_path
        end
      end
    else
      flash[:error] = 'Authentication data is missing or invalid.'
      redirect_to root_path
    end
  end

end