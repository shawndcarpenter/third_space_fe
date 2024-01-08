require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before :each do
    user_login_data
    user_select_loc_data
    visit dashboard_path
  end
  
  it 'allows the user to click the contact button and redirects to a form' do
    expect(current_path).to eq '/dashboard'
    
    expect(page).to have_content('User Dashboard')
    expect(page).to have_button('contact us')

    click_button 'contact us'

    expect(current_path).to eq(new_contact_form_path) 
  end

  it "if there are not any locations near the user, the page will recommend adding one" do
    expect(page).to have_content("Minneapolis, MN")
    expect(page).to have_content("No Third Spaces near you.")
    expect(page).to have_content("Add a location here.")
    expect(page).to have_link("here")
  end

end
