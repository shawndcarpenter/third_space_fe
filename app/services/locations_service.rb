class LocationsService
  def conn
    conn = Faraday.new(url: "https://plankton-app-tavpa.ondigitalocean.app") 
  end

  def get_location_results(name, city)
    response = conn.get("/api/v1/locations/search_locations") do |req|
      req.params["name"] = name
      req.params["city"] = city
    end
    if response.success?
      data = JSON.parse(response.body, symbolize_names: true)[:data]
    else
      { error: "Service temporarily unavailable. Please try again later." }

    end
  end

  def get_location(yelp_id)
    response = conn.get("/api/v1/locations/#{yelp_id}")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end