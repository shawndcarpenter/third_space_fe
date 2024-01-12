class ThirdSpacesService
  def conn
    conn = Faraday.new(url: "https://third-space-fe-uskie.ondigitalocean.app/third-space-be")

    # require 'pry'; binding.pry
  end

  def create_third_space_reviews(review)
    response = conn.post("/api/v1/third_spaces/#{review.yelp_id}/reviews") do |req|
      req.params['yelp_id'] = review.yelp_id
      req.params['name'] = review.name
      req.params['rating'] = review.rating
      req.params['text'] = review.text
    end
  end

  def get_third_space_reviews(yelp_id)
    response = conn.get("/api/v1/third_spaces/#{yelp_id}/reviews")

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def get_spaces_by_name(name)
    response = conn.get("/api/v1/third_spaces/search_by_name") do |req|
      req.params['name'] = name
    end
    data = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
  end

  def get_spaces
    response = conn.get("/api/v1/third_spaces")

    data = JSON.parse(response.body, symbolize_names: true)
    # require 'pry'; binding.pry
  end

  def create_third_space(location, tags)
    response = conn.post("/api/v1/third_spaces") do |req|
      req.params['yelp_id'] = location[:yelp_id]
      req.params['name'] = location[:name]
      req.params['address'] = location[:address]
      req.params['rating'] = location[:rating]
      req.params['phone'] = location[:phone]
      req.params['photos'] = "#{location[:photos]}"
      req.params['lat'] = location[:lat]
      req.params['lon'] = location[:lon]
      req.params['price'] = location[:price]
      req.params['hours'] = "#{location[:hours]}"
      req.params['category'] = location[:category]
      req.params['open_now'] = location[:open_now]
      req.params['tags'] = "#{tags}"
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end
end