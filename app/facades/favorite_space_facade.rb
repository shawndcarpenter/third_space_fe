class FavoriteSpaceFacade
  def initialize(user_id, space_id)
    @user_id = user_id
    @space_id = space_id
  end
  
  def spaces
    service = SavedSpacesService.new
    json = service.add_user_space(@user_id, @space_id)
    unless json[:status] == 404
      @spaces = json[:included].map do |space|
        ThirdSpacePoro.new(space[:attributes])
      end
    end
  end
end