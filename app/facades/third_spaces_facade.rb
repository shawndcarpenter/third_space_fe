class ThirdSpacesFacade
  def initialize
  end
  
  def spaces
    service = ThirdSpacesService.new
    json = service.get_spaces
    @spaces = json[:data].map do |space|
      ThirdSpacePoro.new(space[:attributes])
    end
  end
end