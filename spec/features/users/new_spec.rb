require 'rails_helper'

RSpec.describe "New User Registration", type: :feature do
  describe 'form fields and functionality' do
    before :each do 
      visit register_path 
    end

    it 'has a first name field' do
      expect(page).to have_field("first_name")
    end

    it 'has a last name field' do
      expect(page).to have_field("last_name")
    end

    it 'has an email form' do
      expect(page).to have_field("email")
    end

    it 'has a new password field' do
      expect(page).to have_field("password")
    end

    it 'has a confirm password field' do
      expect(page).to have_field("confirm_password")
    end

    it 'redirects to login page when clicking on "I already have an account"' do
      click_link "I already have an account"
      expect(current_path).to eq(login_path)
    end

    it 'creates an account when valid data is submitted' do
      fill_in "first_name", with: "Candy"
      fill_in "last_name", with: "Land"
      fill_in "email", with: "shawncarpenter.co@gmail.com"
      fill_in "password", with: "test"
      fill_in "confirm_password", with: "test"
      click_button "create new account"   
      expect(current_path).to eq(validate_otp_path)
    end

    it 'shows error message when required fields are missing' do
      # Fill in all fields except last_name
      fill_in "first_name", with: "Candy"
      fill_in "email", with: "shawncarpenter.co@gmail.com"
      fill_in "password", with: "test"
      fill_in "confirm_password", with: "test"
      click_button "create new account"

      # Assuming the application renders a flash message for errors
      expect(page).to have_content("Last name can't be blank")
    end
  end
end
