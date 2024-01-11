class ThirdSpacesByNameFacade
  def initialize(name)
    @name = name
  end
  
  def spaces
    service = ThirdSpacesService.new
    json = service.get_spaces_by_name(@name)
    @spaces = json[:data].map do |space|
      ThirdSpacePoro.new(space[:attributes])
    end
  end
end