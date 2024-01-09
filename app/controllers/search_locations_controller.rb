class SearchLocationsController < ApplicationController
  def create
    if current_user.search_location.nil?
      search_location = current_user.build_search_location(search_params)
      search_location.save
    end
    redirect_to dashboard_path
  end

  private
  def search_params
    params.permit(:city, :state)
  end
end