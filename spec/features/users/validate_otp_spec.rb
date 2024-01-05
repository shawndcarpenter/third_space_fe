require 'rails_helper'

RSpec.describe "validate otp", type: :feature do
  describe 'basic functionality' do
    it 'has an email form' do
      visit validate_otp_path
      expect(page).to have_field("otp")
    end

    xit 'has submit button' do
      visit login_path
      click_button "submit"

      #add path
    end
  
  end
end
