class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    #binding.pry
    if auth.present? && auth['provider'].present? && auth['uid'].present? && auth['info'].present?
      user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |u|
        u.first_name = auth['info']['first_name']
        u.last_name = auth['info']['last_name']
        u.email = auth['info']['email']
        u.password = "x"
      end

      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = 'Authentication data is missing or invalid.'
      redirect_to root_path
    end
  end

end