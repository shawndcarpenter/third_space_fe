class SavedSpacesFacade
  def initialize(user_id)
    @user_id = user_id
  end
  
  def spaces
    service = SavedSpacesService.new
    json = service.get_user_spaces(@user_id)
    return [] if json[:status] == 404
    @spaces = json[:included].map do |space|
      ThirdSpacePoro.new(space[:attributes])
    end
  end
end