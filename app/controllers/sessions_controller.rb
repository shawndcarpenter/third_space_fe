class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    if auth.present? && auth['provider'].present? && auth['uid'].present? && auth['info'].present?
      user = User.find_by(email: auth['info']['email'])
      if user.present? && user.admin?
        session[:user_id] = user.id
        redirect_to admin__dashboarda_path
      elsif
        user.present?
        session[:user_id] = user.id
        redirect_to set_location_path
      else
        new_user = User.new(
          email: auth['info']['email'],
          first_name: auth['info']['first_name'],
          last_name: auth['info']['last_name'],
          password: SecureRandom.hex(16),
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