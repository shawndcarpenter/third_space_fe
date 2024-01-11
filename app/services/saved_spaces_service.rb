class SavedSpacesService

  def conn
    conn = Faraday.new(url: "http://localhost:3000")
  end

  def get_user_spaces(user_id)
    response = conn.get("/api/v1/users/#{user_id}/third_spaces")
    data = JSON.parse(response.body, symbolize_names: true)
  end
end