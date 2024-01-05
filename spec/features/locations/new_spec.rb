require 'rails_helper'

RSpec.describe "new location", type: :feature do
  describe 'basic functionality' do
    it 'has a new space form' do
      visit new_location_path
      expect(page).to have_field("new space")
    end
    it 'has a city form' do
      visit new_location_path
      expect(page).to have_field("city")
    end

    it 'has submit button' do
      visit new_location_path
      expect(page).to have_button('submit new space')
      click_button "submit new space"

      #add path
    end
  
  end
end
