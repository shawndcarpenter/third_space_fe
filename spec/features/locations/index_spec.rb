require "rails_helper"

RSpec.describe "Find Locations", type: :feature do 
  describe "Index" do 
    before :each do
      # user_login_data
      # user_select_loc_data
      # click_link "here"

      # fill_in :name, with: "Five Watt"
      # fill_in :city, with: "Minneapolis"
      # click_button "submit"
    end

    it "displays all markets" do 
      VCR.use_cassette("all_market_cassette") do
        user_login_data
        user_select_loc_data
        sleep(0.3)
        click_link "here"
        sleep(0.3)
        fill_in :name, with: "Five Watt"
        fill_in :city, with: "Minneapolis"
        click_button "submit"
        expect(current_path).to eq("/locations")
        
        expect(page).to have_content("Five Watt")
        expect(page).to have_content("3745 Nicollet Ave S, Minneapolis, MN 55409")
        expect(page).to have_content("Coffee & Tea")

        expect(page).to have_content("Five Watt Coffee Lyndale")
        expect(page).to have_content("3350 Lyndale Ave S, Minneapolis, MN 55408")
      end
    end

    it "user can select name of business to go to the show page" do
      VCR.use_cassette("single_business_cassette") do
        user_login_data
        sleep(0.3)
        user_select_loc_data
        click_link "here"
  
        fill_in :name, with: "Five Watt"
        fill_in :city, with: "Minneapolis"
        click_button "submit"
        within("#location_result-5pWHnKN3_AIrXiyyqZ74pw") do
          click_link "Five Watt"
        end
        expect(current_path).to eq(location_path("5pWHnKN3_AIrXiyyqZ74pw"))
      end
    end
  end
end