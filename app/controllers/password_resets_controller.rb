class PasswordResetsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      PasswordMailer.with(user: @user).reset.deliver_now
    end
    redirect_to '/login', notice: 'If an account with that email was found, we have sent a link to reset password'
  
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to '/login', alert: 'Your token has expired. Please try again'
  end

  def update
    @user = User.find_signed!(params[:token], purpose: 'password_reset')

    if @user.update(user_params)
      redirect_to '/login', notice: 'Your password was reset succesfully. Please sign in.'
    else
      render 'edit'
    end
    rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to '/login', alert: 'Your token has expired. Please try again'
  end
  private
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
