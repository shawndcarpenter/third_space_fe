require "rails_helper"

RSpec.describe "Find Locations", type: :feature do 
  describe "Index" do 
    it 'has basic functionality and appearance' do
      visit locations_path
      expect(page).to have_selector("input[placeholder='where are you today?']")
    end
    it 'has a search field' do
      visit locations_path
      expect(page).to have_field("search")
    end
    it 'has search button' do
      visit locations_path
      expect(page).to have_button("search")
    end
    # xit "displays all markets" do 
      # As a visitor,
      # When I visit '/locations'
      # I see all locations listed with their name, address, lat and lon
      # When I click a button to see more info on that market
      # I'm taken to that market's show page '/locations/:id'

      #webmock stub
    #   json_response = File.read("")

    #   stub_request(:get, "http://127.0.0.1:3000/api/v0/locations").
    #      with(
    #        headers: {
    #       'Accept'=>'*/*',
    #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #       'User-Agent'=>'Faraday v2.7.12'
    #        }).
    #      to_return(status: 200, body: json_response, headers: {})
    #     # use postman to copy the api data into a fixture file 

         
    #   visit "/locations"
    #   expect(page).to have_content("Locations")
    #   expect(page).to have_content("Name")
    #   expect(page).to have_content("Address")
    #   expect(page).to have_content("Latitude and Longitude")
    # end
  end
end