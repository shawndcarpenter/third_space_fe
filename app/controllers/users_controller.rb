class UsersController < ApplicationController

  def show
    current_user
    if @_current_user && current_user.admin?
      @user = User.find(params[:user_id])
    elsif @_current_user && current_user.default?
      @user = User.find(@_current_user.id)
    else
      flash[:error] = "Must be logged in to view your dashboard."
      redirect_to "/"
    end
  end
  
  def new
    @user = User.new
  end

  def create
    user = users_params
    user[:email] = user[:email].downcase
    new_user = User.create(user)
    if new_user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.email}!"
      redirect_to "/users/#{new_user.id}"
    else
      flash[:notice] = "#{new_user.errors.full_messages.join(', ')}"
      redirect_to "/register"
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        redirect_to "/"
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have been logged out successfully."
    redirect_to "/"
  end

  private
  def users_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

end