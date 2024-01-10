class UsersController < ApplicationController

  def dashboard
    @user = current_user
    @search_location = @user.search_location
    city = @search_location.city
    state = @search_location.state
    
    @recommended = filter_spaces_by_location(find_spaces, city, state)
  end

  # def make_
  #   conn = Faraday.new(url: "http://localhost:3000") do |faraday|
  #     faraday.params["api_key"] = Rails.application.credentials.yelp[:key]
  #     faraday.params["name"] = Rails.application.credentials.yelp[:key]
  #   end

  #   response = conn.get("/api/v1/locations/search_locations")

  # end

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
  
  def support
    
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
      initiate_verification(new_user)
    else
      flash[:notice] = "#{new_user.errors.full_messages.join(', ')}"
      redirect_to "/register"
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:error] = "Sorry, we are unable to find a user with this e-mail. Please check credentials or create an account."
      redirect_to login_path
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      if user.admin?
        redirect_to admin_dashboard_path
      else
        initiate_verification(user)
      end
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def initiate_verification(user)
    user.generate_otp_secret_key
    user.update(otp_code: user.generate_otp, otp_code_expires_at: 5.minutes.from_now)
    user.save
    session[:code] = user.otp_code
    session[:otp_expires_at] = 5.minutes.from_now
    UserMailer.send_otp_email(user).deliver_now
    redirect_to validate_otp_path
  end

  def validate_otp
    entered_otp = params[:otp]
    if session[:code] == entered_otp && session[:otp_expires_at] > Time.current
      redirect_to set_location_path, notice: 'OTP verification successful!'
      session.delete(:code)
      session.delete(:otp_expires_at)
      session[:user_id] = current_user.id
    elsif session[:code] == entered_otp && session[:otp_expires_at] < Time.current
      redirect_to login_path, notice: 'OTP session has expired. Please try logging in again.'
    else
      flash[:alert] = 'Invalid OTP. Please try again.'
      redirect_to validate_otp_path
    end
  end

  def validate_otp_form
    # Render the page where users can enter the OTP
  end

  def logout
    reset_session
    flash[:success] = "You have been logged out successfully."
    redirect_to "/"
  end

  def set_location_form
    @user = current_user
  end

  private
  def users_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end

  def find_spaces
    conn = Faraday.new(url: "http://localhost:3000")
    response = conn.get("/api/v1/third_spaces")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    return [] if data.nil?
    
    third_spaces = data.map do |d|
      ThirdSpacePoro.new(d[:attributes])
    end
  end

  def filter_spaces_by_location(results, city, state)
    results.find_all do |space|
      address_parts = space.address.split(',').map(&:strip)
      space_city = address_parts[-2]
      space_state = address_parts[-1]
      space_city == city && space_state.include?(state)
    end
  end

end