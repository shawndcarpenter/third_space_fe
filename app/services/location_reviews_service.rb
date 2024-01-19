class LocationReviewsService
  def conn
    conn = Faraday.new(url: "https://plankton-app-tavpa.ondigitalocean.app")
  end

  def get_location_reviews(yelp_id)
    response = conn.get("api/v1/locations/#{yelp_id}/reviews")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
  end
end