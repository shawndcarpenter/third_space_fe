require 'date'

class ThirdSpacesController < ApplicationController

  def new
    @json = params[:location_json]
    json_parse = JSON.parse(params[:location_json], symbolize_names: true)
    @location = DetailedLocation.new(json_parse)
  end
  
  def create_third_space
    location = JSON.parse(params[:location_json], symbolize_names: true)
    tags = params[:tags]

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

    tags = params[:tags]
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
    unless @reviews.nil? || @reviews.empty?
      avg_rating(@reviews)
    end
  end

  def search
    @user = current_user
    if params[:name]
      @spaces = ThirdSpacesByNameFacade.new(params[:name]).spaces
    elsif params[:tags]
      @spaces = ThirdSpacesByTagsFacade.new(params[:tags]).spaces
        params[:tags].each do |tag|
        @spaces.delete_if { |space| space.tags == nil || !space.tags.include?(tag) }
      end
    end
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
    @tags_with_freq = format_tags(@space.tags)
    @tags = @tags_with_freq.map { |key,value| key }

    @transportation_tag = find_transportation_tags(@space.tags).first.first
    @mood_tags = find_moods(@space.tags)
    @light_level = find_light_level(@space.tags).first.first
    @noise_level = find_noise_level(@space.tags).first.first
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
  def find_noise_level(tags)
    noise_tags = []
    tags.map do |tag|
      if tag == "Loud" || tag == "Quiet" || tag == "Average Noise Level"
       noise_tags << tag
      end
    end
    sort_tags_by_frequency(noise_tags)
  end

  def find_transportation_tags(tags)
    transportation_tags = []
    tags.map do |tag|
      if tag == "Transportation Nearby" || tag == "No Transporation Nearby"
       transportation_tags << tag
      end
    end
    sort_tags_by_frequency(transportation_tags)
  end

  def find_child_tags(tags)
    child_tags = []
    tags.map do |tag|
      if tag == "Child Friendly" || tag == "Not Child Friendly"
       child_tags << tag
      end
    end
    sort_tags_by_frequency(child_tags)
  end

  def find_bipoc_tags(tags)
    bipoc_tags = []
    tags.map do |tag|
      if tag == "BIPOC Friendly" || tag == "Not BIPOC Friendly"
       bipoc_tags << tag
      end
    end
    sort_tags_by_frequency(bipoc_tags)
  end

  def find_lgbt_tags(tags)
    lgbt_tags = []
    tags.map do |tag|
      if tag == "Queer Friendly" || tag == "Not Queer Friendly"
       lgbt_tags << tag
      end
    end
      sort_tags_by_frequency(lgbt_tags)
  end

  def find_accessible_tags(tags)
    accessible_tags = []
    tags.map do |tag|
      if tag == "Accessible" || tag == "Not Accessible"
       accessible_tags << tag
      end
    end
    sort_tags_by_frequency(accessible_tags)
  end

  def find_parking_tags(tags)
    parking_tags = []
    tags.map do |tag|
      if tag == "Parking" || tag == "No Parking"
       parking_tags << tag
      end
    end
    sort_tags_by_frequency(parking_tags)
  end

  def find_gn_restroom_tags(tags)
    gn_restroom_tags = []
    tags.map do |tag|
      if tag == "Gender Neutral Restrooms" || tag == "No Gender Neutral Restrooms"
       gn_restroom_tags << tag
      end
    end
    sort_tags_by_frequency(gn_restroom_tags)
  end

  def find_customer_restroom_tags(tags)
   customer_restroom_tags = []
    tags.map do |tag|
      if tag == "Customer Restrooms" || tag == "No Customer Restrooms"
       customer_restroom_tags << tag
      end
    end
    sort_tags_by_frequency(customer_restroom_tags)
  end

  def find_sober_tags(tags)
    sober_tags = []
    tags.map do |tag|
      if tag == "Sober" || tag == "Non Sober"
        sober_tags << tag
      end
    end
    sort_tags_by_frequency(sober_tags)
  end

  def find_purchase_necessary_tags(tags)
    purchase_tags = []
    tags.map do |tag|
      if tag == "Purchase Necessary" || tag == "No Purchase Necessary"
        purchase_tags << tag
      end
    end
    sort_tags_by_frequency(purchase_tags)
  end

  def find_staff_tags(tags)
    staff_tags = []
    tags.map do |tag|
      if tag == "Pushy" || tag == "Helpful" || tag == "Respectful"
        staff_tags << tag
      end
    end
    sort_tags_by_frequency(staff_tags)
  end

  def find_light_level(tags)
    light_tags = []
    tags.map do |tag|
      if tag == "Bright" || tag == "Moody" || tag == "Average Lighting"
        light_tags << tag
      end
    end
    sort_tags_by_frequency(light_tags)
  end

  def find_moods(tags)
    mood_tags = []
    tags.map do |tag|
      if tag == "Happy" || tag == "Studious" || tag == "Sad" || tag == "Social" || tag == "Party" || tag == "Chill"
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

  def avg_rating(reviews)
    sum = 0.0
    total_ratings = 0.0
    iteration = @reviews.each do |r|
      sum += r.rating.to_f
      total_ratings += 1
    end
    @avg_rating = sum/total_ratings
  end

  def find_third_space(yelp_id)
    conn = Faraday.new(url: "https://third-space-fe-uskie.ondigitalocean.app/third-space-be")
    response = conn.get("api/v1/third_spaces/#{yelp_id}")
    data = JSON.parse(response.body, symbolize_names: true)[:data]
    ThirdSpacePoro.new(data[:attributes])
  end
end