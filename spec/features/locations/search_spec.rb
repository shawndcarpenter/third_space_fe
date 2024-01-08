require "rails_helper"

RSpec.describe "Location Search Page", type: :feature do 
  before :each do
    user_login_data
    user_select_loc_data
    click_link "here"
  end

  describe "Search Page" do 
    it "has a form with fields for name and city" do
      expect(current_path).to eq(locations_search_path)
      expect(page).to have_content("What is the name and city of this third space?")
      expect(page).to have_field('name')
      expect(page).to have_field('city')
    end

    it "use can submit and entries and redirect to the search index" do
      fill_in :city, with: "Five Watt"
      fill_in :city, with: "Minneapolis"
      click_button "submit"
      expect(current_path).to eq("/locations")
    end

    it "will return all results that follow" do
      expect(page).to have_content("Five Watt")
      expect(page).to have_content("3745 Nicollet Ave S, Minneapolis, MN 55409")
      expect(page).to have_content("Coffee & Tea")

      expect(page).to have_content("Five Watt Coffee Lyndale")
      expect(page).to have_content("3350 Lyndale Ave S, Minneapolis, MN 55408")
    end
  end
end