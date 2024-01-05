require 'rails_helper'

RSpec.describe "new user", type: :feature do
  describe 'basic functionality' do
    it 'has an email form' do
      visit new_user_path
      expect(page).to have_field("email")
    end
    it 'has a new password field' do
      visit new_user_path
      expect(page).to have_field("password")
    end
    it 'has a confirm password field' do
      visit new_user_path
      expect(page).to have_field("confirm_password")
    end
  
  end
end
