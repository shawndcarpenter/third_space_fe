require 'rails_helper'

RSpec.describe 'Set Location Page', type: :feature do
  before :each do
    user_login_data
  end

  it 'has city or address input' do
    expect(current_path).to eq(set_location_path)
    expect(page).to have_content("Where would you like to search?")
    expect(page).to have_field('City')
    expect(page).to have_field('State')
    # expect(page).to have_field('Address') ## Ignore for now, will be better with GeoLocator
  end
end
