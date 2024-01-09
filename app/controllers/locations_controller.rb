class LocationsController < ApplicationController
  
  def search
  end
  
  def index
    @location_results = find_locations
  end
  
  def show
    location_id = params[:id]
    @location = find_show_details(location_id)
    @location_json = @location.to_json
  end

  def create
  end
  
  private

  def find_locations
    conn = Faraday.new(url: "http://localhost:3000") do |faraday| 
      faraday.params["name"] = params[:name]
      faraday.params["city"] = params[:city]
    end
    response = conn.get("/api/v1/locations/search_locations")
    data = JSON.parse(response.body, symbolize_names: true)[:data]

    search_results = data.map do |d|
      SearchResult.new(d[:attributes])
    end
  end

  def find_show_details(location_id)
    conn = Faraday.new(url: "http://localhost:3000/")
    response = conn.get("api/v1/locations/#{location_id}")
    json = JSON.parse(response.body, symbolize_names: true)[:data][:attributes]

    DetailedLocation.new(json)
  end
end