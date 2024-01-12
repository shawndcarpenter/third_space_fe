class LocationsController < ApplicationController
  
  def search
  end
  
  def index
    @third_space_yelp_ids = third_space_yelp_ids
    name = params[:name]
    city = params[:city]
    @location_results = LocationsFacade.new(name, city).locations
    ##Create error when data is NIL to make new entries
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
end