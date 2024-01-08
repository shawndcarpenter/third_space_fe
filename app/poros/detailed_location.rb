class DetailedLocation
    attr_reader :id, 
    :yelp_id, 
    :name, 
    :address, 
    :rating, 
    :phone, 
    :photos, 
    :lat, 
    :lon, 
    :price, 
    :hours, 
    :category,
    :open_now

  def initialize(data)
    @yelp_id = data[:yelp_id]
    @name = data[:name]
    @address = data[:address]
    @rating = data[:rating]
    @phone = data[:phone]
    @photos = data[:photos]
    @lat = data[:lat]
    @lon = data[:lon]
    @price = data[:price]
    @hours = data[:hours]
    @open_now = data[:open_now]
    @category = data[:category]
  end
end