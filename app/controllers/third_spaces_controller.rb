class ThirdSpacesController < ApplicationController

  def new
    @json = params[:location_json]
    json_parse = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json_parse)
  end
  
  def create_third_space
    location = JSON.parse(params[:location_json], symbolize_names: true)
    location = location.to_h.transform_keys(&:to_s)
    tags = params[:tags].map{|tag| tag.downcase.split.join("_")}
    new_third_space_call(location, tags)
    redirect_to dashboard_path
  end

  private

  def new_third_space_call(json_data, tags)
    conn = Faraday.new(url: "http://localhost:3000") do |faraday| 
      faraday.headers['Content-Type'] = 'application/json'
      faraday.body = json_data
    end

    response = conn.post("/api/v1/third_spaces")
    data = JSON.parse(response.body, symbolize_names: true)
  end

end