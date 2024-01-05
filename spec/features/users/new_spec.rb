require 'rails_helper'

RSpec.describe "new user", type: :feature do
  describe 'basic functionality' do
    it 'has a first name field' do
      visit new_user_path
      expect(page).to have_field("first_name")
    end
    it 'has a last name field' do
      visit new_user_path
      expect(page).to have_field("last_name")
    end
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
    it 'has I already have an account' do
      visit new_user_path
      click_link "I already have an account"
      expect(current_path).to eq(login_path)
    end
    it 'creates an account' do
      visit new_user_path
      click_button "create new account"
      #add more to this
    end
  
  end
end
