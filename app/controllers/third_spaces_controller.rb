class ThirdSpacesController < ApplicationController

  def new
    json = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json)
  end

  def create
  end

end