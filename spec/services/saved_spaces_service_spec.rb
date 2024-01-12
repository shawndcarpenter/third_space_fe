require 'rails_helper'

describe SavedSpacesService do
  context "instance methods" do
    context "#get_space_details" do
      it "connects", :vcr do
        service = SavedSpacesService.new 
        expect(service.conn).to be_instance_of Faraday::Connection
      end

      it "get_user_spaces", :vcr do
        user = User.create(first_name: 'Candy', last_name: 'Land', email: 'shawncarpenter.co@gmail.com', password: 'test')
        user.update!(id: "12345")
        space_id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = SavedSpacesService.new.get_user_spaces(user.id)
        expect(search).to be_a Hash
      end

      it "add_user_space", :vcr do
        user = User.create(first_name: 'Candy', last_name: 'Land', email: 'shawncarpenter.co@gmail.com', password: 'test')
        user.update!(id: "12345")
        space_id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = SavedSpacesService.new.add_user_space(user.id, space_id)
        expect(search).to be_a Hash
      end
      
      it "remove_user_space(user_id, yelp_id)", :vcr do
        user = User.create(first_name: 'Candy', last_name: 'Land', email: 'shawncarpenter.co@gmail.com', password: 'test')
        user.update!(id: "12345")
        space_id = "f-m7-hyFzkf0HSEeQ2s-9A"
        search = SavedSpacesService.new.remove_user_space(user.id, space_id)
        data = JSON.parse(search.body, symbolize_names: true)
        expect(data).to be_a Hash
      end
    end
  end
end