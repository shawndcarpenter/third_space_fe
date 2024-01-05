require 'rails_helper'

RSpec.describe "validate otp", type: :feature do
  describe 'basic functionality' do
    it 'has an email form' do
      visit validate_otp_path
      expect(page).to have_field("otp")
    end

    it 'has submit button' do
      visit validate_otp_path
      click_button "submit"

      #add path
    end
  
  end
end
