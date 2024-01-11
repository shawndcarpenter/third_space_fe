require 'rails_helper'

RSpec.describe 'Contact Support Form' do
  before :each do
    # user_login_data
    # user_select_loc_data
    # visit new_contact_form_path
  end

  xit 'successfully submits the contact form and redirects to dashboard' do
    VCR.use_cassette("contact form w redirect") do
      user_login_data
      user_select_loc_data
      visit new_contact_form_path
      fill_in 'subject', with: 'Test Subject'
      fill_in 'description', with: 'Test message content'

      expect {
        click_button 'submit'
      }.to change(Contact, :count).by(1)

      expect(page).to have_current_path(dashboard_path)
      expect(page).to have_content('Your message has been submitted successfully')
    end
  end
end