require 'rails_helper'

describe LocationsService do
  context "instance methods" do
    context "#get_space_details" do
      it "connects", :vcr do
        service = LocationsService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "get_location_results(name, city)", :vcr do
        name = "Starbucks"
        city = "Boulder"
        search = LocationsService.new.get_location_results(name, city)

        expect(search).to be_an Array
      end

      it "get_location(yelp_id)", :vcr do
        yelp_id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = LocationsService.new.get_location(yelp_id)

        expect(search).to be_a Hash
      end
    end
  end
end