class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    return nil unless session[:user_id]
  
    begin
      @_current_user ||= User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      reset_session
      nil
    end
  end
  
  
  def current_admin?
    current_user && current_user.admin?
  end

  def find_show_reviews(yelp_id)
    reviews = LocationReviewsFacade.new(yelp_id).reviews
  end  
end
