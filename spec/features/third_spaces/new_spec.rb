require "rails_helper"

RSpec.describe "New Third Space Form", type: :feature do 
  before :each do
    user_login_data
    user_select_loc_data
    click_link "here"

    fill_in :name, with: "Five Watt"
    fill_in :city, with: "Minneapolis"
    click_button "submit"

    within("#location_result-5pWHnKN3_AIrXiyyqZ74pw") do
      click_link "Five Watt"
    end
    
    click_link("Create a Third Space")
  end

  describe "General Third Space details displayed" do 
    it "lists the the general details including name, category, address, section for tags" do
      expect(page).to have_content("Five Watt Coffee")
      expect(page).to have_content("Coffee & Tea")
      expect(page).to have_content("3745 Nicollet Ave S, Minneapolis, MN 55409")
      expect(page).to have_button("Create")

      expect(page).to have_content('Accessible Entrance')
      expect(page).to have_content('BIPOC Friendly')
      expect(page).to have_content('Child Friendly')
      expect(page).to have_content('Customer Restrooms')
      expect(page).to have_content('Gender Neutral Restrooms')
      expect(page).to have_content('Parking')
      expect(page).to have_content('Purchase Necessary')
      expect(page).to have_content('Public Transportation Nearby')
      expect(page).to have_content('Queer Friendly')
      expect(page).to have_content('Sober')
      expect(page).to have_content('Staff Responsiveness')
      expect(page).to have_content('Volume')
    end

    it "can take the user to the new Third Space form" do
      expect(current_path).to eq(new_third_space_path)
    end
  end
end