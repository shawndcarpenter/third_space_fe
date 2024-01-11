class ThirdSpacesController < ApplicationController

  def new
    @json = params[:location_json]
    json_parse = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json_parse)
  end
  
  def create_third_space
    location = JSON.parse(params[:location_json], symbolize_names: true)
    tags = params[:tags].map{|tag| tag.downcase.split.join("_")}
    
    new_third_space_call(location, tags)
    redirect_to dashboard_path
  end

  def search
    @spaces = ThirdSpacesFacade.new(params[:name]).spaces
  end

  def favorite
    user_id = current_user.id
    space_id = params[:yelp_id]
    spaces = FavoriteSpaceFacade.new(user_id, space_id).spaces

    redirect_to dashboard_path
  end

  def unfavorite
    user_id = current_user.id
    yelp_id = params[:yelp_id]
    spaces = UnfavoriteSpaceFacade.new(user_id, yelp_id).spaces
    
    redirect_to dashboard_path
  end

  private
  def new_third_space_call(location, tags)
    conn = Faraday.new(url: "http://localhost:3000") do |faraday| 
      faraday.headers['Content-Type'] = 'application/json'
    end

    response = conn.post("/api/v1/third_spaces") do |req|
      req.params['yelp_id'] = location[:yelp_id]
      req.params['name'] = location[:name]
      req.params['address'] = location[:address]
      req.params['rating'] = location[:rating]
      req.params['phone'] = location[:phone]
      req.params['photos'] = "#{location[:photos]}"
      req.params['lat'] = location[:lat]
      req.params['lon'] = location[:lon]
      req.params['price'] = location[:price]
      req.params['hours'] = "#{location[:hours]}"
      req.params['category'] = location[:category]
      req.params['open_now'] = location[:open_now]
      req.params['tags'] = "#{tags}"
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end
end