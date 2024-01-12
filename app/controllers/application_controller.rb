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
    conn = Faraday.new(url: "http://localhost:3000/")
    response = conn.get("api/v1/locations/#{yelp_id}/reviews")
    data = JSON.parse(response.body, symbolize_names: true)[:data]

    reviews = data.map do |d|
      ReviewPoro.new(d[:attributes])
    end
  end  
end
