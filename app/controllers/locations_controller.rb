class LocationsController < ApplicationController
  
  def search
  end
  
  def index
    @location_results = find_locations
  end

  # #NOT SETUP -- THESE ARE PLACEHOLDERS AT THE MOMENT UNTIL BE IS SETUP
  # def index
  #   #refactor into service/poro/facade that also instantiates locations as objects
  #   response = Faraday.get("http://127.0.0.1:3000/api/v0/locations")
  #   @data = JSON.parse(response.body, symbolize_names: true)
  # end

  # def show
  #   #refactor into service/poro/facade that also instantiates location as object
  #   location_id = params[:id]
  #   response = Faraday.get("http://127.0.0.1:3000/api/v0/locations/#{location_id}")
  #   @data = JSON.parse(response.body, symbolize_names: true)
  # end

  def new
    # require 'pry'; binding.pry
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
end