class DestroyThirdSpaceFacade
  def initialize(yelp_id)
    @yelp_id = yelp_id
  end
  
  def destroyed
    service = ThirdSpacesService.new
    json = service.destroy_space(@yelp_id)
  end
end