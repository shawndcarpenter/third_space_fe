class UnfavoriteSpaceFacade
  def initialize(user_id, yelp_id)
    @user_id = user_id
    @yelp_id = yelp_id
  end
  
  def spaces
    service = SavedSpacesService.new
    json = service.remove_user_space(@user_id, @yelp_id)
  end
end