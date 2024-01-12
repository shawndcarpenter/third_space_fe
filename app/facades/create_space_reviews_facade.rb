class CreateSpaceReviewsFacade
  def initialize(review)
    @review = review
  end

  def new_review
    service = ThirdSpacesService.new
    json = service.create_third_space_reviews(@review)
  end
end