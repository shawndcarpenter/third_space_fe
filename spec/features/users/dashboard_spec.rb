require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before :each do
    user_login_data
  end
  
  it 'allows the user to click the contact button and redirects to a form' do
    expect(current_path).to eq '/dashboard'
    
    expect(page).to have_content('User Dashboard')
    expect(page).to have_button('contact us')

    click_button 'contact us'

    expect(current_path).to eq(new_contact_form_path) 
  end
end
