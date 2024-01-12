require 'rails_helper'

RSpec.describe 'Location details page', type: :feature, vcr: true do
  before do
    VCR.use_cassette('location_details') do
      visit location_path('4qFHQIs2Nux2EVP2EdfZHA') 
    end
  end

  it 'displays the location name, category, and address' do
    expect(page).to have_content('Costco Wholesale')
    expect(page).to have_content('Gas Stations')
    expect(page).to have_content("Address: 900 S Harbor Blvd, Fullerton, CA 92832")
  end

  it 'displays whether the location is open or closed' do
    expect(page).to have_content('Open Now')
  end

  it 'displays the location rating' do
    expect(page).to have_content("Rating: 3.5")
  end

  it 'displays the reviews for the location' do
    expect(page).to have_content('Costco Wholesale is an exceptional shopping destination. The membership benefits alone are worth it')
  end

  it 'provides a link to create a third space' do
    expect(page).to have_link('Create a Third Space')
  end
end
