class SearchLocationsController < ApplicationController
  def create
    if current_user.search_location.nil? && params[:mood].present?
      geolocation = geocode_location(session[:lat], session[:lon])
      geo_hash = geolocation_parse(geolocation)
      search_location = current_user.build_search_location(geo_hash)
      search_location.save
      search_location.update(mood: params[:mood])
    elsif current_user.search_location.nil?
      search_location = current_user.build_search_location(search_params)
      search_location.save
    elsif !current_user.search_location.nil? && params[:mood].present?
      geolocation = geocode_location(session[:lat], session[:lon])
      geo_hash = geolocation_parse(geolocation)
      current_user.search_location.update(geo_hash)
      current_user.search_location.update(mood: params[:mood])
    else
      current_user.search_location.update(search_params)
    end
    redirect_to dashboard_path
  end

  def update
    # binding.pry
  end

  
  private
  def search_params
    params.permit(:city, :state)
  end

  def geocode_location(lat, lon)
    results = Geocoder.search([lat, lon])
    results.first.address
  end
  
  def geolocation_parse(geolocation)
    address_parts = geolocation.split(',').map(&:strip)
    city = address_parts[4]
    state = address_parts[6]
    geo_hash = { city: city, state: state }
    geo_hash
  end
end