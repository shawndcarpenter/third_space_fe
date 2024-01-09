require "rails_helper"

RSpec.describe "Location Search Page", type: :feature do 
  # before :each do
  #   user_login_data
  #   user_select_loc_data
  #   click_link "here"
  # end

  describe "Search Page", :vcr do
    it "has a form with fields for name and city if there are not any locations available" do
      VCR.use_cassette("name and city") do 
        user_login_data
        user_select_loc_data
        save_and_open_page
        click_link "here"
        expect(current_path).to eq(locations_search_path)
        expect(page).to have_content("What is the name and city of this third space?")
        expect(page).to have_field('name')
        expect(page).to have_field('city')
      end
    end

    xit "user can submit and entries and redirect to the search index" do
      VCR.use_cassette("fill in name and city") do 
        user_login_data
        sleep(0.3)
        user_select_loc_data
        click_link "here"
        sleep(0.2)
        fill_in :name, with: "Five Watt"
        fill_in :city, with: "Minneapolis"
        click_button "submit"
        expect(current_path).to eq("/locations")
      end
    end
  end
end