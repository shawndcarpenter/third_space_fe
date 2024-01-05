class LocationsController < ApplicationController
  

  #NOT SETUP -- THESE ARE PLACEHOLDERS AT THE MOMENT UNTIL BE IS SETUP
  def index
    #refactor into service/poro/facade that also instantiates locations as objects
    response = Faraday.get("http://127.0.0.1:3000/api/v0/locations")
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  def show
    #refactor into service/poro/facade that also instantiates location as object
    location_id = params[:id]
    response = Faraday.get("http://127.0.0.1:3000/api/v0/locations/#{location_id}")
    @data = JSON.parse(response.body, symbolize_names: true)
  end

  def new
    # require 'pry'; binding.pry
  end

  def create
    
  end
  
end