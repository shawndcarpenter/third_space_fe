class ThirdSpacesController < ApplicationController

  def new
    # require 'pry'; binding.pry
    @json = params[:location_json]
    json_parse = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json_parse)
  end
  
  def create_third_space
    location = JSON.parse(params[:location_json], symbolize_names: true)
    tags = params[:tags].map{|tag| tag.downcase.split.join("_")}
    # new_third_space_call(location, tags)
    CreateThirdSpaceFacade.new(location, tags).space
    redirect_to dashboard_path
  end

  def search
    @user = current_user
    @spaces = ThirdSpacesByNameFacade.new(params[:name]).spaces
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
  end

  def favorite
    user_id = current_user.id
    space_id = params[:yelp_id]
    facade = FavoriteSpaceFacade.new(user_id, space_id)
    facade.spaces

    redirect_to dashboard_path
  end

  def unfavorite
    user_id = current_user.id
    yelp_id = params[:yelp_id]
    facade = UnfavoriteSpaceFacade.new(user_id, yelp_id)
    facade.spaces
    
    redirect_to dashboard_path
  end

  def show
    yelp_id = params[:id]
    @space = find_third_space(yelp_id)
    @reviews = find_show_reviews(yelp_id)
    @tags = @space.tags
    if !@tags.nil?
      @tags = @space.tags.uniq.map{|t| t.gsub('_', ' ').titleize}
      #separate moods and other
    else
      @tags = []
    end
  end

  private
  # def new_third_space_call(location, tags)
  #   conn = Faraday.new(url: "http://localhost:3000") do |faraday| 
  #     faraday.headers['Content-Type'] = 'application/json'
  #   end

  #   response = conn.post("/api/v1/third_spaces") do |req|
  #     req.params['yelp_id'] = location[:yelp_id]
  #     req.params['name'] = location[:name]
  #     req.params['address'] = location[:address]
  #     req.params['rating'] = location[:rating]
  #     req.params['phone'] = location[:phone]
  #     req.params['photos'] = "#{location[:photos]}"
  #     req.params['lat'] = location[:lat]
  #     req.params['lon'] = location[:lon]
  #     req.params['price'] = location[:price]
  #     req.params['hours'] = "#{location[:hours]}"
  #     req.params['category'] = location[:category]
  #     req.params['open_now'] = location[:open_now]
  #     req.params['tags'] = "#{tags}"
  #   end

  #   data = JSON.parse(response.body, symbolize_names: true)
  # end

  def saved_yelp_ids(spaces)
    list = []
    spaces.map do |space|
      list << space.yelp_id
    end
    list
  end

  def find_third_space(yelp_id)
    conn = Faraday.new(url: "http://localhost:3000/")
    response = conn.get("api/v1/third_spaces/#{yelp_id}")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    ThirdSpacePoro.new(data[:attributes])
  end
end