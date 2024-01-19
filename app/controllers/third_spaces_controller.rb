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

  # def add_review
  #   space = CreateThirdSpaceFacade.new(location, tags).space
  #   review = ReviewPoro.new(name: @user.first_name, text: params[:text], rating: params[:rating], yelp_id: space[:data][:attributes][:yelp_id])
    
  #   @review = CreateSpaceReviewsFacade.new(review)
  # end

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

    if @reviews == []
      reviews = LocationReviewsFacade.new(yelp_id).reviews
      reviews.map do |review|
        CreateSpaceReviewsFacade.new(review).new_review
      end

      @reviews = ThirdSpaceReviewsFacade.new(yelp_id).reviews
    end
    @tags_with_freq = format_tags(@space.tags)
    @tags = @tags_with_freq.map { |key,value| key }

    @transportation_tag = find_transportation_tags(@space.tags).first.first
    @mood_tags = find_moods(@space.tags)
    @light_level = find_light_level(@space.tags).first.first
    @staff_tags = find_staff_tags(@space.tags).first.first
    @purchase_necessary = find_purchase_necessary_tags(@space.tags).first.first
    @sober_tag = find_sober_tags(@space.tags).first.first
    @customer_restrooms = find_customer_restroom_tags(@space.tags).first.first
    @gn_restrooms = find_gn_restroom_tags(@space.tags).first.first
    @parking_tag = find_parking_tags(@space.tags).first.first
    @accessible_tags = find_accessible_tags(@space.tags).first.first
    @bipoc_tag = find_bipoc_tags(@space.tags).first.first
    @lgbt_tag = find_lgbt_tags(@space.tags).first.first
    @child_friendly = find_child_tags(@space.tags).first.first
    # binding.pry
  end

  def destroy
    def destroy
      yelp_id = params[:id]
      DestroyThirdSpaceFacade.new(yelp_id).destroyed
      redirect_to dashboard_path
    end
  end
  
  private
  def format_tags(tags)
    if !tags.nil?
      tags = tags.map{ |tag| tag.gsub('_', ' ').titleize }
      # binding.pry
      sort_tags_by_frequency(tags)
      #separate moods and other
    else
      []
    end
  end

  def sort_tags_by_frequency(tags)
    tag_frequency = tags.inject(Hash.new(0)) { |tag,frequency| tag[frequency] += 1; tag }
    tag_frequency.sort_by { |tag,frequency| frequency}.reverse!
    # binding.pry
    if tag_frequency.empty?
      [[]]
    else
      tag_frequency
    end
  end
  def sort_if_not_empty

  end

  def find_transportation_tags(tags)
    transportation_tags = []
    tags.map do |tag|
      if tag == "transportation_nearby" || tag == "no_transportation_nearby"
       transportation_tags << tag
      end
    end
    # binding.pry
      sort_tags_by_frequency(transportation_tags)
  end

  def find_child_tags(tags)
    child_tags = []
    tags.map do |tag|
      if tag == "child_friendly" || tag == "not_child_friendly"
       child_tags << tag
      end
    end
    sort_tags_by_frequency(child_tags)
  end

  def find_bipoc_tags(tags)
    bipoc_tags = []
    tags.map do |tag|
      if tag == "bipoc_friendly" || tag == "not_bipoc_friendly"
       bipoc_tags << tag
      end
    end
    sort_tags_by_frequency(bipoc_tags)
  end

  def find_lgbt_tags(tags)
    lgbt_tags = []
    tags.map do |tag|
      if tag == "lgbt_friendly" || tag == "not_lgbt_friendly"
       lgbt_tags << tag
      end
    end
      sort_tags_by_frequency(lgbt_tags)
  end

  def find_accessible_tags(tags)
    accessible_tags = []
    tags.map do |tag|
      if tag == "accessible" || tag == "non_accessible"
       accessible_tags << tag
      end
    end
    sort_tags_by_frequency(accessible_tags)
  end

  def find_parking_tags(tags)
    parking_tags = []
    tags.map do |tag|
      if tag == "parking" || tag == "no_parking"
       parking_tags << tag
      end
    end
    sort_tags_by_frequency(parking_tags)
  end

  def find_gn_restroom_tags(tags)
    gn_restroom_tags = []
    tags.map do |tag|
      if tag == "gender_neutral_restrooms" || tag == "no_gender_neutral_restrooms"
       gn_restroom_tags << tag
      end
    end
    sort_tags_by_frequency(gn_restroom_tags)
  end

  def find_customer_restroom_tags(tags)
   customer_restroom_tags = []
    tags.map do |tag|
      if tag == "customer_restrooms" || tag == "no_customer_restrooms"
       customer_restroom_tags << tag
      end
    end
    sort_tags_by_frequency(customer_restroom_tags)
  end

  def find_sober_tags(tags)
    sober_tags = []
    tags.map do |tag|
      if tag == "sober" || tag == "non_sober"
        sober_tags << tag
      end
    end
    sort_tags_by_frequency(sober_tags)
  end

  def find_purchase_necessary_tags(tags)
    purchase_tags = []
    tags.map do |tag|
      if tag == "purchase_necessary" || tag == "no_purchase_necessary"
        purchase_tags << tag
      end
    end
    sort_tags_by_frequency(purchase_tags)
  end

  def find_staff_tags(tags)
    staff_tags = []
    tags.map do |tag|
      if tag == "pushy" || tag == "helpful" || tag == "respectful"
        staff_tags << tag
      end
    end
    sort_tags_by_frequency(staff_tags)
  end

  def find_light_level(tags)
    light_tags = []
    tags.map do |tag|
      if tag == "bright" || tag == "moody" || tag == "average_lighting"
        light_tags << tag
      end
    end
    sort_tags_by_frequency(light_tags)
  end

  def find_moods(tags)
    mood_tags = []
    tags.map do |tag|
      if tag == "happy" || tag == "studious" || tag == "sad" || tag == "social" || tag == "party" || tag == "chill"
        mood_tags << tag
      end
    end
    sort_tags_by_frequency(mood_tags)
  end


  def saved_yelp_ids(spaces)
    list = []
    spaces.map do |space|
      list << space.yelp_id
    end
    list
  end
end