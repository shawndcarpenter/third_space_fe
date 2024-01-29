require "rails_helper"

RSpec.describe "New Third Space Form", type: :feature do 
  # before :each do
    # user_login_data
    # user_select_loc_data
    # sleep(0.3)
    # click_link "here"
    # sleep(0.3)
    
    # fill_in :name, with: "Five Watt"
    # fill_in :city, with: "Minneapolis"
    # click_button "submit"
    # sleep(0.3)

    # within("#location_result-5pWHnKN3_AIrXiyyqZ74pw") do
    #   click_link "Five Watt"
    # end
    
    # click_link("Create a Third Space")
  # end

  # describe "General Third Space details displayed", :vcr do 
  #   xit "lists the the general details including name, category, address, section for tags" do
  #     VCR.use_cassette("general info and tags") do
  #       user_login_data
  #       user_select_loc_data
  #       sleep(0.3)
  #       click_link "here"
  #       sleep(0.3)
        
  #       fill_in :name, with: "Five Watt"
  #       fill_in :city, with: "Minneapolis"
  #       click_button "submit"
  #       sleep(0.3)
    
  #       within("#location_result-5pWHnKN3_AIrXiyyqZ74pw") do
  #         click_link "Five Watt"
  #       end
        
  #       click_link("Create a Third Space")
        
  #       click_link("Create a Third Space")
  #     expect(page).to have_content("Five Watt Coffee")
  #     expect(page).to have_content("Coffee & Tea")
  #     expect(page).to have_content("3745 Nicollet Ave S, Minneapolis, MN 55409")
  #     expect(page).to have_button("Create")

  #     expect(page).to have_content('Accessible Entrance')
  #     expect(page).to have_content('BIPOC Friendly')
  #     expect(page).to have_content('Child Friendly')
  #     expect(page).to have_content('Customer Restrooms')
  #     expect(page).to have_content('Gender Neutral Restrooms')
  #     expect(page).to have_content('Parking')
  #     expect(page).to have_content('Purchase Necessary')
  #     expect(page).to have_content('Public Transportation Nearby')
  #     expect(page).to have_content('Queer Friendly')
  #     expect(page).to have_content('Sober')
  #     expect(page).to have_content('Staff responsiveness')
  #     expect(page).to have_content('Volume')
  #     expect(page).to have_content('Lighting')
  #     end
  #   end

    # xit "user can select tags for the submissions" do
    #   # Check 'Happy' mood
    #   # find("input[name='moods[]'][value='Happy']", visible: :all).check
    
    #   # # Select 'Helpful' from 'Staff Responsiveness'
    #   select 'Helpful', from: 'tags_staff_responsiveness'

    #   # # Select 'Quiet' from 'Volume'
    #   # select 'Quiet', from: 'tags[]'

    #   # # Select 'Moody' from 'Lighting'
    #   # select 'Moody', from: 'tags[]'
    
    #   # Check other tags
    #   checkbox_labels = ['Accessible Entrance', 'BIPOC Friendly', 'Child Friendly', 'Customer Restrooms', 'Gender Neutral Restrooms', 'Parking', 'Purchase Necessary', 'Queer Friendly', 'Sober']
    #   checkbox_labels.each do |label|
    #     next if label == 'Volume'
    #     find("input[name='tags[]'][value='#{label}']", visible: :all).check
    #   end
    
    #   click_button 'Create'
    #   expect(current_path).to eq(dashboard_path)
    # end
    
  # end
end