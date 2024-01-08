class SearchLocationsController < ApplicationController
  def create
    current_user.build_search_location(search_params)
    redirect_to dashboard_path
  end

  private
  def search_params
    params.permit(:city, :state)
  end
end