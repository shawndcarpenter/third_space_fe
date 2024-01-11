class CreateThirdSpaceFacade
  def initialize(location, tags)
    @location = location
    @tags = tags
  end
  
  def space
    service = ThirdSpacesService.new

    json = service.create_third_space(@location, @tags)
  end
end