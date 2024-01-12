require 'rails_helper'

RSpec.describe 'Set Location Page', type: :feature do
  before :each do
    user_login_data
  end

  it 'has city or address input' do
    user_login_data
    expect(current_path).to eq(set_location_path)
    expect(page).to have_content("Where would you like to search today?")
    expect(page).to have_field('city')
    expect(page).to have_field('state')
    # expect(page).to have_field('Address') ## Ignore for now, will be better with GeoLocator
  end

  xit "user can submit a location and search", vcr: { cassette_name: 'user_location_search' } do
    VCR.use_cassette('user_location_search') do
      user_login_data
      fill_in 'city', with: 'Minneapolis'
      select 'MN', from: :state
      click_button "submit"
      expect(current_path).to eq(dashboard_path)
      save_and_open_page
      expect(page).to have_content("Minneapolis, MN")
    end
  end

  xit "can use a user's location and mood attribute when button is selected" do
    user_login_data
    click_button "Happy"
    expect(current_path).to eq(dashboard_path)
    expect(current_url).to eq("http://www.example.com/dashboard?mood=happy")
  end

end
