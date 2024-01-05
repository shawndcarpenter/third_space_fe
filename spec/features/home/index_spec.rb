require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :feature do
  describe 'basic functionality' do
    it 'has a login link' do
      visit root_path
      click_link("Login")
      expect(current_path).to eq(login_path)
    end
    it 'has a new user link' do
      visit root_path
      click_link("New User")
      expect(current_path).to eq(register_path)
    end
  
  end
end
