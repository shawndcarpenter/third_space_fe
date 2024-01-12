require 'rails_helper'

describe ThirdSpacesService do
  context "instance methods" do
    context "#get_space_details" do
      it "connects", :vcr do
        service = ThirdSpacesService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "searches for reviews for a specific id", :vcr do
        id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = ThirdSpacesService.new.get_third_space_reviews(id)
        expect(search).to be_a Hash
      end

      it "updates tags", :vcr do
        id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = ThirdSpacesService.new.update_space_tags(id, ["happy"])
        expect(search).to be_a Hash
      end

      it "get_spaces_by_name", :vcr do
        name = "name"
        search = ThirdSpacesService.new.get_spaces_by_name(name)
        expect(search).to be_a Hash
      end

      it "get_spaces", :vcr do
        search = ThirdSpacesService.new.get_spaces
        expect(search).to be_a Hash
      end

      it "get_space", :vcr do
        id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = ThirdSpacesService.new.get_space(id)
        expect(search).to be_a Hash
      end

      it "create_third_space", :vcr do
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
        category: "yummy",
        open_now: true}
        tags = ["happy"]
        search = ThirdSpacesService.new.create_third_space(location, tags)
        expect(search).to be_a Hash
      end

      it "create_third_reviews", :vcr do
        data = {
        yelp_id: "f-m7-hyFzkf0HSEeQ2s-9A",
        name: "name",
        text: "text",
        rating: "5"}
        review = ReviewPoro.new(data)
        search = ThirdSpacesService.new.create_third_space_reviews(review)
        data = JSON.parse(search.body, symbolize_names: true)
        expect(data).to be_a Hash
      end
    end
  end
end