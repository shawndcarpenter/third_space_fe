class ThirdSpaceFacade
  def initialize(yelp_id)
    @yelp_id = yelp_id
  end
  
  def space
    service = ThirdSpacesService.new
    json = service.get_space(@yelp_id)
    ThirdSpacePoro.new(json[:data][:attributes])
  end
end