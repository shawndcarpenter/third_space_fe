require 'rails_helper'

RSpec.describe "oauth", type: :feature do
  describe 'basic functionality' do
    it 'can login with google' do
      visit "/"
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
        provider: 'google_oauth2',
        uid: '123456',
        info: {
          email: 'user@example.com',
          name: 'John Doe'
        }
      })
      click_button "Sign up with Google"
      expect(page).to have_content("Welcome, John Doe!")
      expect(current_path).to eq "/"
    end
  end
end