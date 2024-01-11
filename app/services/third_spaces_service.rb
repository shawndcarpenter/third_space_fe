class ThirdSpacesService
  def conn
    conn = Faraday.new(url: "http://localhost:3000")
  end

  def get_spaces_by_name(name)
    response = conn.get("/api/v1/third_spaces/search_by_name") do |req|
      req.params['name'] = name
    end
    data = JSON.parse(response.body, symbolize_names: true)
  end

  def get_spaces
    response = conn.get("/api/v1/third_spaces")
    
    data = JSON.parse(response.body, symbolize_names: true)
  end
end