class SearchLocationsController < ApplicationController
  def create
    if (params["city"].present? && params["state"].present?) && params[:mood].present?
      current_user.search_location.update(city: params["city"], state: params["state"], mood: params["mood"])
      redirect_to dashboard_path 
    elsif (session[:lat].nil? || session[:lon].nil?) && params[:mood].present?
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
      search_location.update(mood: params[:mood])
    elsif current_user.search_location.nil?
      search_location = current_user.build_search_location(search_params)
      search_location.save
    elsif !current_user.search_location.nil? && params[:mood].present?
      # require 'pry'; binding.pry
      geolocation = geocode_location(session[:lat], session[:lon])
      geo_hash = geolocation_parse(geolocation)
      current_user.search_location.update(geo_hash)
      current_user.search_location.update(mood: params[:mood])
    else
      current_user.search_location.update(city: search_params[:city], state: search_params[:state])
    end
  end

  def update
    current_user.search_location.update(mood: params[:mood])
    redirect_to dashboard_path
  end
  
  private
  def search_params
    params.permit(:city, :state)
  end

  def search_location_params
    params.require(:search_location).permit(:city, :state, :mood)
  end

  def geocode_location(lat, lon)
    results = Geocoder.search([lat, lon])
    results.first.data["address"]["city"] + " " + results.first.data["address"]["state"]
  end
  
  def geolocation_parse(geolocation)
    address_parts = geolocation.split(' ').map(&:strip)
    city = address_parts[0]
    state = address_parts[1]
    return geo_hash = { city: city, state: state_to_abv(state) } if state.length != 2
    geo_hash = { city: city, state: state }
  end

  def state_to_abv(state_name)
    state_abbreviations = {
                          'Alabama' => 'AL',
                          'Alaska' => 'AK',
                          'Arizona' => 'AZ',
                          'Arkansas' => 'AR',
                          'California' => 'CA',
                          'Colorado' => 'CO',
                          'Connecticut' => 'CT',
                          'Delaware' => 'DE',
                          'Florida' => 'FL',
                          'Georgia' => 'GA',
                          'Hawaii' => 'HI',
                          'Idaho' => 'ID',
                          'Illinois' => 'IL',
                          'Indiana' => 'IN',
                          'Iowa' => 'IA',
                          'Kansas' => 'KS',
                          'Kentucky' => 'KY',
                          'Louisiana' => 'LA',
                          'Maine' => 'ME',
                          'Maryland' => 'MD',
                          'Massachusetts' => 'MA',
                          'Michigan' => 'MI',
                          'Minnesota' => 'MN',
                          'Mississippi' => 'MS',
                          'Missouri' => 'MO',
                          'Montana' => 'MT',
                          'Nebraska' => 'NE',
                          'Nevada' => 'NV',
                          'New Hampshire' => 'NH',
                          'New Jersey' => 'NJ',
                          'New Mexico' => 'NM',
                          'New York' => 'NY',
                          'North Carolina' => 'NC',
                          'North Dakota' => 'ND',
                          'Ohio' => 'OH',
                          'Oklahoma' => 'OK',
                          'Oregon' => 'OR',
                          'Pennsylvania' => 'PA',
                          'Rhode Island' => 'RI',
                          'South Carolina' => 'SC',
                          'South Dakota' => 'SD',
                          'Tennessee' => 'TN',
                          'Texas' => 'TX',
                          'Utah' => 'UT',
                          'Vermont' => 'VT',
                          'Virginia' => 'VA',
                          'Washington' => 'WA',
                          'West Virginia' => 'WV',
                          'Wisconsin' => 'WI',
                          'Wyoming' => 'WY'
                        }
    state_abbreviations[state_name]
  end
end