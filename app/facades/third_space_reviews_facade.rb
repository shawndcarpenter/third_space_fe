class ThirdSpaceReviewsFacade
  def initialize(yelp_id)
    @yelp_id = yelp_id
  end

  def reviews
    service = ThirdSpacesService.new
    json = service.get_third_space_reviews(@yelp_id)

    @reviews = json[:data].map do |review|
      ReviewPoro.new(review[:attributes])
    end
  end
end