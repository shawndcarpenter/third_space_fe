class UpdateSpaceTagsFacade
  def initialize(yelp_id, tags)
    @yelp_id = yelp_id
    @tags = tags
  end
  
  def space
    service = ThirdSpacesService.new
    json = service.update_space_tags(@yelp_id, @tags)
    ThirdSpacePoro.new(json[:data][:attributes])
  end
end