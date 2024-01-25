class LocationsService
  def conn
    conn = Faraday.new(url: "http://localhost:3000") 
    
  end

  def get_location_results(name, city)
    response = conn.get("/api/v1/locations/search_locations") do |req|
      req.params["name"] = name
      req.params["city"] = city
    end

    data = JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def get_location(yelp_id)
    response = conn.get("api/v1/locations/#{yelp_id}")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end