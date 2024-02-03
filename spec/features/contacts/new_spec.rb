require 'rails_helper'

RSpec.describe 'Contact Support Form' do
  # it 'successfully submits the contact form and redirects to dashboard' do
  #   VCR.use_cassette("contact form w redirect", record: :new_episodes) do
  #     user_login_data
  #     user_select_loc_data
  #     visit new_contact_form_path
  #     fill_in 'subject', with: 'Test Subject'
  #     fill_in 'description', with: 'Test message content'

  #     expect {
  #       click_button 'submit'
  #     }.to change(Contact, :count).by(1)

  #     expect(page).to have_current_path(dashboard_path)
  #     expect(page).to have_content('Your message has been submitted successfully')
  #   end
  # end

  it 'does not submit the contact form and renders the page again' do
    VCR.use_cassette("contact form w redirect", record: :new_episodes) do
      user_login_data
      user_select_loc_data
      visit new_contact_form_path
      fill_in 'subject', with: ''
      fill_in 'description', with: 'Test'

      click_button 'submit'
  
      expect(page).to have_current_path(new_contact_form_path)
      expect(page).to have_content('There was an error submitting your message. Please try again.')
    end
  end
end