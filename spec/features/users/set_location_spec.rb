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

  it "user can submit a location and search" do
    VCR.use_cassette("search location") do
      user_login_data
      sleep(0.3)
      find('input[name="city"]').set("Minneapolis")
      select 'MN', from: :state
      click_button "submit"
      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content("Search Location: Minneapolis, MN")
    end
  end
end
