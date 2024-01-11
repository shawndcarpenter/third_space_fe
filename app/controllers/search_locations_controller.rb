class SearchLocationsController < ApplicationController
  def create
    if (session[:lat].nil? || session[:lon].nil?) && params[:mood].present?
      flash[:error] = "Error fetching location. Please make sure you have granted permission to access your location."
      redirect_to set_location_path
    else
      update_search_location
      redirect_to dashboard_path
    end
  end

  def update_search_location
    if current_user.search_location.nil? && params[:mood].present?
      geolocation = geocode_location(session[:lat], session[:lon])
      geo_hash = geolocation_parse(geolocation)
      search_location = current_user.build_search_location(geo_hash)
      search_location.save
    elsif current_user.search_location.nil?
      search_location = current_user.build_search_location(search_params)
      search_location.save
    elsif !current_user.search_location.nil? && params[:mood].present?
      geolocation = geocode_location(session[:lat], session[:lon])
      geo_hash = geolocation_parse(geolocation)
      current_user.search_location.update(geo_hash)
    else
      current_user.search_location.update(search_params)
    end
  end
  
  def geocode_location(lat, lon)
      results = Geocoder.search([lat, lon])
      results.first.address
  end

  def geolocation_parse(geolocation)
    address_parts = geolocation.split(',').map(&:strip)
    city = address_parts[3]
    state = address_parts[4]
    geo_hash = { city: city, state: state }
    geo_hash
  end

  private
  def search_params
    params.permit(:city, :state)
  end
end