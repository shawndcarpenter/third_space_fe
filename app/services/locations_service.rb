class LocationsService
  def conn
    conn = Faraday.new(url: "http://localhost:3000") do |faraday| 
      faraday.params["name"] = params[:name]
      faraday.params["city"] = params[:city]
    end

  def get_location_results(name, city)
    response = conn.get("/api/v1/locations/search_locations")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    return [] if data.nil? 
  end

end