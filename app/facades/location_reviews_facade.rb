class LocationReviewsFacade
  def initialize(yelp_id)
    @yelp_id = yelp_id
  end

  def reviews
    service = LocationReviewsService.new
    json = service.get_location_reviews(@yelp_id)
    if json
      @reviews = json.map do |review|
        ReviewPoro.new(review[:attributes])
      end
    else
      @reviews = []
    end
  end
end