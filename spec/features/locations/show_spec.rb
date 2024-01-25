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

  it 'displays the location rating' do
    expect(page).to have_content("Rating: 3.5")
  end

  it 'displays the reviews for the location' do
    expect(page).to have_content('If I could give it a zero, I would. Ridiculous planning and traffic control for this gas station. They have 2 barricades up for 2 lines when ultimately...')
  end

  it 'provides a link to create a third space' do
    expect(page).to have_link('Create a Third Space')
  end
end
