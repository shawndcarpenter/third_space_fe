class LocationReviewsFacade
  def initialize(yelp_id)
    @yelp_id = yelp_id
  end

  def reviews
    service = LocationReviewsService.new
    json = service.get_location_reviews(@yelp_id)
    # require 'pry'; binding.pry
    @reviews = json.map do |review|
      ReviewPoro.new(review[:attributes])
    end
  end
end