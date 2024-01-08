require 'rails_helper'

RSpec.describe 'Saved Locations Index', type: :feature do
  before :each do
    user_login_data
    visit saved_locations_path
  end

  xit 'page exists' do
    expect(page).to have_content('Saved Locations')
    # expect(page).to have_button('contact us')
    # expect(page).to have_button('contact us')

    # expect(current_path).to eq(new_contact_form_path) 
  end
end
