class SearchLocationsController < ApplicationController
  def create
    search_location = current_user.build_search_location(search_params)
    search_location.save
    redirect_to dashboard_path
  end

  private
  def search_params
    params.permit(:city, :state)
  end
end