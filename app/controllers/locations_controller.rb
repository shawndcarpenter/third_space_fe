class LocationsController < ApplicationController
  
  def search
  end
  
  def index
    if params[:name].empty? || params[:city].empty?
      redirect_to locations_search_path
      flash[:alert] = "Please fill in search bars with the name of a location and city where this location is located. (Example: name: Starbucks, city: Boulder)"
    else
    @third_space_yelp_ids = third_space_yelp_ids
    name = params[:name]
    city = params[:city]
    @location_results = LocationsFacade.new(name, city).locations
    end
  end
  
  def show
    location_id = params[:id]
    @location = LocationFacade.new(location_id).location
    @location_json = @location.to_json
    @reviews = LocationReviewsFacade.new(location_id).reviews
  end

  def new
  end

  def create
  end
  
  private


  def third_space_yelp_ids
    spaces = ThirdSpacesFacade.new.spaces
    list = []
    spaces.map do |space|
      list << space.yelp_id
    end
    list
  end

  def find_locations
    conn = Faraday.new(url: "https://third-space-fe-uskie.ondigitalocean.app/third-space-be") do |faraday| 
      faraday.params["name"] = params[:name]
      faraday.params["city"] = params[:city]
    end
    response = conn.get("/api/v1/locations/search_locations")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    return [] if data.nil? 

    search_results = data.map do |d|
      SearchResult.new(d[:attributes])
    end
  end

  def find_show_details
    location_id = params[:id]
    conn = Faraday.new(url: "https://third-space-fe-uskie.ondigitalocean.app/third-space-be")
    response = conn.get("api/v1/locations/#{location_id}")
    # require 'pry'; binding.pry
    json = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    DetailedLocation.new(json)
  end

  # def find_show_reviews
  #   location_id = params[:id]
  #   conn = Faraday.new(url: "http://localhost:3000/")
  #   response = conn.get("api/v1/locations/#{location_id}/reviews")
  #   data = JSON.parse(response.body, symbolize_names: true)[:data]

  #   reviews = data.map do |d|
  #     ReviewPoro.new(d[:attributes])
  #   end
  # end

  
end