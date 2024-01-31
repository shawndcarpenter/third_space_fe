class ThirdSpacesByTagsFacade
  def initialize(tags)
    @tags = tags
  end
  
  def spaces
    service = ThirdSpacesService.new
    json = service.get_spaces_by_tags(@tags)
    @spaces = json[:data].map do |space|
      ThirdSpacePoro.new(space[:attributes])
    end
  end
end