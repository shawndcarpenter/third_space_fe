require 'rails_helper'

RSpec.describe "new user", type: :feature do
  describe 'basic functionality' do
    xit 'has a first name field' do
      visit new_user_path
      expect(page).to have_field("first_name")
    end
    xit 'has a last name field' do
      visit new_user_path
      expect(page).to have_field("last_name")
    end
    xit 'has an email form' do
      visit new_user_path
      expect(page).to have_field("email")
    end
    xit 'has a new password field' do
      visit new_user_path
      expect(page).to have_field("password")
    end
    xit 'has a confirm password field' do
      visit new_user_path
      expect(page).to have_field("confirm_password")
    end
    xit 'has I already have an account' do
      visit new_user_path
      click_link "I already have an account"
      expect(current_path).to eq(login_path)
    end
    xit 'creates an account' do
      visit new_user_path
      click_button "create new account"
      #add more to this
    end
  
  end
end
