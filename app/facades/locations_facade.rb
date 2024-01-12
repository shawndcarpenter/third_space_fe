class LocationsFacade
  def initialize(name, city)
    @name = name
    @city = city
  end

  def locations
    service = LocationsService.new
    json = service.get_location_results(@name, @city)

    @search_results = json.map do |search_result|
      SearchResult.new(search_result[:attributes])
    end
  end
end