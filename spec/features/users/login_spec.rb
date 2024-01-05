require 'rails_helper'

RSpec.describe "login", type: :feature do
  describe 'basic functionality' do
    it 'has an email form' do
      visit login_path
      expect(page).to have_field("email")
    end
    it 'has a password field' do
      visit login_path
      expect(page).to have_field("password")
    end
    xit 'has log in button' do
      visit login_path
      click_link("log in")
    end
    xit 'creates an account' do
      visit login_path
      click_button "create new account"
      expect(current_path).to eq(new_user_path)
      #add more to this
    end
  
  end
end
