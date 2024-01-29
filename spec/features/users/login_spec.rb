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
  
  end
end
