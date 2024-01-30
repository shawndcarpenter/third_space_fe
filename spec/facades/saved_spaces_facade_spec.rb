require "rails_helper"

RSpec.describe SavedSpacesFacade do  
  it "#spaces", :vcr do
  location = {
    yelp_id: "f-m7-hyFzkf0HSEeQ2s-9A",
    name: "name",
    address: "address",
    rating: "5",
    phone: "555-555-5555",
    photos: "[]",
    lat: 123.4545,
    lon: 123455.67,
    price: "$$$",
    hours: {},
    category: "yummy"
}
    tags = ["happy"] 
    search = ThirdSpacesService.new.create_third_space(location, tags)
    user = User.create(first_name: 'Candy', last_name: 'Land', email: 'test@test.test', password: 'test')
    user.update!(id: "12345")
    
    user_space = SavedSpacesService.new.add_user_space(user.id, search[:data][:attributes][:yelp_id])
    spaces = SavedSpacesFacade.new(user.id).spaces
    expect(spaces).to be_a(Array)
    spaces.each do |space|
      expect(space.address).to be_a(String)
      expect(space.category).to be_a(String)
      expect(space.name).to be_a(String)
      expect(space).to be_instance_of(ThirdSpacePoro)
    end
  end
end