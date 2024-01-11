class SavedSpacesService
  def conn
    conn = Faraday.new(url: "http://localhost:3000")
  end

  def get_user_spaces(user_id)
    response = conn.get("/api/v1/users/#{user_id}/third_spaces")
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def add_user_space(user_id, space_id)
    response = conn.post("/api/v1/user_third_spaces") do |req|
      req.params['user_id'] = user_id
      req.params['third_space_id'] = space_id
    end

    data = JSON.parse(response.body, symbolize_names: true)
  end

  def remove_user_space(user_id, yelp_id)
    response = conn.delete("/api/v1/user_third_spaces") do |req|
      req.params['user_id'] = user_id
      req.params['third_space_id'] = yelp_id
    end
  end
end