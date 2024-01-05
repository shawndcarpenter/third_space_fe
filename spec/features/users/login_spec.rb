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
    it 'has log in button' do
      visit login_path
      expect(page).to have_button("log in")
    end
    it 'creates an account' do
      visit login_path
      click_link "create new account"
      expect(current_path).to eq(register_path)
      #add more to this
    end
  
  end
end
