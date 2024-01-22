class UsersController < ApplicationController

  def dashboard
    @user = current_user

    if params[:mood]
      @mood = params[:mood]
    end
    @search_location = @user.search_location
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
    spaces = ThirdSpacesFacade.new.spaces
    location_recs = filter_spaces_by_location(spaces)
    @mood_recs = filter_by_mood(location_recs)
    
    @location_recs = location_recs.reject! do |location|
      @mood_recs.any? { |mood_rec| location.name == mood_rec.name }
    end
  end

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

  def privacy
    
  end

  def login_form
  end

  def mood_recommendations_index
    @user = current_user
    @search_location = @user.search_location
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
    spaces = ThirdSpacesFacade.new.spaces

    @recommendation_results = @mood_recs = filter_by_mood(filter_spaces_by_location(spaces))
  end

  def loc_recommendations_index
    @user = current_user
    @search_location = @user.search_location
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
    spaces = ThirdSpacesFacade.new.spaces
    @recommendation_results = filter_spaces_by_location(spaces)
  end

  def saved_list
    @user = current_user
    @search_location = @user.search_location
    city = @search_location.city
    state = @search_location.state
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
    spaces = ThirdSpacesFacade.new.spaces
    @recommended = filter_spaces_by_location(spaces)
  end

  def login
    user = User.find_by(email: params[:email])
    if user.nil?
      flash[:error] = "Sorry, we are unable to find a user with this e-mail. Please check credentials or create an account."
      redirect_to login_path
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.email}!"
      initiate_verification(user)
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
    session[:email] = user.email
    UserMailer.send_otp_email(user).deliver_now
    redirect_to validate_otp_path
  end

  def validate_otp
    entered_otp = params[:otp]
    user = User.find_by_email(session[:email])
    if session[:code] == entered_otp && session[:otp_expires_at] > Time.current && user.admin?
      login_session_clear
      redirect_to admin_dashboard_path, notice: 'OTP verification successful!'
    elsif session[:code] == entered_otp && session[:otp_expires_at] > Time.current
        redirect_to set_location_path, notice: 'OTP verification successful!'
        login_session_clear
    elsif session[:code] == entered_otp && session[:otp_expires_at] < Time.current
      redirect_to login_path, notice: 'OTP session has expired. Please try logging in again.'
    else
      flash[:alert] = 'Invalid OTP. Please try again.'
      redirect_to validate_otp_path
    end
  end

  def login_session_clear
    session.delete(:code)
    session.delete(:otp_expires_at)
    session.delete(:email)
    session[:user_id] = current_user.id
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

  def saved_yelp_ids(spaces)
    list = []
    spaces.map do |space|
      list << space.yelp_id
    end
    list
  end

  def filter_spaces_by_location(results)
    city = current_user.search_location.city.capitalize
    state = current_user.search_location.state
    locs = [] 
    results.find_all do |space|
      if !space.address.nil?
        address_parts = space.address.split(',').map(&:strip)
        space_city = address_parts[-2]
        space_state = address_parts[-1]
        match = space_city.include?(city) && space_state.include?(state)
        if match
        locs << space 
        end
      end
      locs
    end
  end

  def filter_by_mood(results)
    mood = current_user.search_location.mood
    results.find_all do |space|
      next if space.tags.nil?
      space.tags.include?(mood)
    end
  end

end