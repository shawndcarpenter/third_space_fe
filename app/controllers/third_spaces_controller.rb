require 'date'

class ThirdSpacesController < ApplicationController

  def new
    @json = params[:location_json]
    json_parse = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json_parse)
  end
  
  def create_third_space
    location = JSON.parse(params[:location_json], symbolize_names: true)
    tags = params[:tags].map{|tag| tag.downcase.split.join("_")}

    CreateThirdSpaceFacade.new(location, tags).space
    
    redirect_to dashboard_path
  end

  def edit
    @user = current_user
    yelp_id = params[:id]
    @space = ThirdSpaceFacade.new(yelp_id).space
  end

  def update
    @user = current_user
    yelp_id = params[:id]

    @space = ThirdSpaceFacade.new(yelp_id).space

    tags = params[:tags].map{|tag| tag.downcase.split.join("_")}
    @space = UpdateSpaceTagsFacade.new(yelp_id, tags).space

    redirect_to third_space_path(@space.yelp_id)
  end

  def add_review
    @user = current_user
    yelp_id = params[:id]
    @space = ThirdSpaceFacade.new(yelp_id).space
  end

  def save_review
    @user = current_user
    yelp_id = params[:id]
    @space = ThirdSpaceFacade.new(yelp_id).space
    name = @user.first_name + ' ' + @user.last_name.first + '.'
    date = Date.today.strftime("%Y-%m-%d")
    review_poro = ReviewPoro.new(name: name, text: params[:text], rating: params[:rating], date: date, yelp_id: yelp_id)
    @review = CreateSpaceReviewsFacade.new(review_poro).new_review
    redirect_to "/third_spaces/#{yelp_id}"
    flash[:success] = "Review created successfully!"
  end

  def all_reviews
    @user = current_user
    yelp_id = params[:id]
    @space = ThirdSpaceFacade.new(yelp_id).space
    @reviews = ThirdSpaceReviewsFacade.new(yelp_id).reviews
    if @reviews != []
      avg_rating(@reviews)
    end
  end

  def search
    @user = current_user
    @spaces = ThirdSpacesByNameFacade.new(params[:name]).spaces
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
  end

  def favorite
    user_id = current_user.id
    space_id = params[:yelp_id]
    facade = FavoriteSpaceFacade.new(user_id, space_id)
    facade.spaces

    redirect_back(fallback_location: dashboard_path)
  end

  def unfavorite
    user_id = current_user.id
    yelp_id = params[:yelp_id]
    facade = UnfavoriteSpaceFacade.new(user_id, yelp_id)
    facade.spaces
    
    redirect_back(fallback_location: dashboard_path)
  end

  def show
    @user = current_user
    yelp_id = params[:id]
    @space = ThirdSpaceFacade.new(yelp_id).space
    @reviews = ThirdSpaceReviewsFacade.new(yelp_id).reviews
    @saved = SavedSpacesFacade.new(@user.id).spaces
    @saved_yelp_ids = saved_yelp_ids(@saved)
    if @reviews != []
      avg_rating(@reviews)
    end
    
    if @reviews == []
      reviews = LocationReviewsFacade.new(yelp_id).reviews
      reviews.map do |review|
        CreateSpaceReviewsFacade.new(review).new_review
      end
      
      @reviews = ThirdSpaceReviewsFacade.new(yelp_id).reviews
    end
    @tags = @space.tags
    if !@tags.nil?
      @tags = @space.tags.uniq.map{|t| t.gsub('_', ' ').titleize}
      #separate moods and other
    else
      @tags = []
    end
  end

  def destroy
    def destroy
      yelp_id = params[:id]
      DestroyThirdSpaceFacade.new(yelp_id).destroyed
      redirect_to dashboard_path
    end
  end

  private
  def saved_yelp_ids(spaces)
    list = []
    spaces.map do |space|
      list << space.yelp_id
    end
    list
  end

  def avg_rating(reviews)
    sum = 0.0
    total_ratings = 0.0
    iteration = @reviews.each do |r|
      sum += r.rating.to_f
      total_ratings += 1
    end
    @avg_rating = sum/total_ratings
  end

end