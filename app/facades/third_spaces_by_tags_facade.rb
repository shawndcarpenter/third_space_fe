class ThirdSpacesByTagsFacade
  def initialize(tags, city, state)
    @tags = tags
    @city = city
    @state = state
  end
  
  def spaces
    service = ThirdSpacesService.new
    json = service.get_spaces_by_tags(@tags, @city, @state)
    @spaces = json[:data].map do |space|
      ThirdSpacePoro.new(space[:attributes])
    end
  end
end