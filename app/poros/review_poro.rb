class ReviewPoro
  attr_reader :id, 
  :yelp_id, 
  :rating,
  :text,
  :name

  def initialize(data)
    @yelp_id = data[:yelp_id]
    @rating = data[:rating]
    @text = data[:text]
    @name = data[:name]
  end
end