class ThirdSpacesController < ApplicationController

  def new
    json = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json)
  end

  def create_third_space
    # binding.pry
    redirect_to dashboard_path
  end

end