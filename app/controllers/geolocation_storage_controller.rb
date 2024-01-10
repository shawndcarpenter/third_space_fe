class GeolocationStorageController < ApplicationController
  protect_from_forgery with: :null_session

  def lat_lon_session

    latitude = params[:latitude]
    longitude = params[:longitude]

    session[:lat] = latitude
    session[:lon] = longitude
    render json: { message: 'Location received successfully' }
  end
end