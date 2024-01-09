require 'rails_helper'

RSpec.describe "new user", type: :feature do
  describe 'basic functionality' do
    it 'has a first name field' do
      visit register_path
      expect(page).to have_field("first_name")
    end
    it 'has a last name field' do
      visit register_path
      expect(page).to have_field("last_name")
    end
    it 'has an email form' do
      visit register_path
      expect(page).to have_field("email")
    end
    it 'has a new password field' do
      visit register_path
      expect(page).to have_field("password")
    end
    it 'has a confirm password field' do
      visit register_path
      expect(page).to have_field("confirm_password")
    end
    it 'has I already have an account' do
      visit register_path
      click_link "I already have an account"
      expect(current_path).to eq(login_path)
    end
    it 'creates an account' do
      visit register_path
      fill_in "first_name", with: "Candy"
      fill_in "last_name", with: "Land"
      fill_in "email", with: "shawncarpenter.co@gmail.com"
      fill_in "password", with: "test"
      fill_in "confirm_password", with: "test"
      click_button "create new account"   
      expect(current_path).to eq(validate_otp_path)
    end
  
  end
end
