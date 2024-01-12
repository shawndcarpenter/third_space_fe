class LocationFacade
  def initialize(yelp_id)
    @yelp_id = yelp_id
  end

  def location
    service = LocationsService.new
    json = service.get_location(@yelp_id)

    # @location = json.map do |review|
      DetailedLocation.new(json[:attributes])
    # end
  end
end