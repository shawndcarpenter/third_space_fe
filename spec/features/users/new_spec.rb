require 'rails_helper'

RSpec.describe "New User Registration", type: :feature do
  describe 'form fields and functionality' do
    before :each do 
      visit register_path 
    end

    it 'has a first name field' do
      expect(page).to have_field("first name")
    end

    it 'has a last name field' do
      expect(page).to have_field("last name")
    end

    it 'has an email form' do
      expect(page).to have_field("email")
    end

    it 'has a new password field' do
      expect(page).to have_field("password")
    end

    it 'has a confirm password field' do
      expect(page).to have_field("password confirmation")
    end

    it 'redirects to login page when clicking on "I already have an account"' do
      click_link "Already Have an Account"
      expect(current_path).to eq(login_path)
    end

    it 'creates an account when valid data is submitted', :vcr do
      fill_in "first name", with: "Candy"
      fill_in "last name", with: "Land"
      fill_in "email", with: "test@test.test"
      fill_in "password", with: "test"
      fill_in "password confirmation", with: "test"
      click_button "Create New Account"   
      expect(current_path).to eq(validate_otp_path)
    end

    it 'shows error message when required fields are missing' do
      # Fill in all fields except last_name
      fill_in "first name", with: "Candy"
      fill_in "email", with: "test@test.test"
      fill_in "password", with: "test"
      fill_in "password confirmation", with: "test"
      click_button "Create New Account"

      expect(page).to have_content("Last name can't be blank")
    end
  end
end
