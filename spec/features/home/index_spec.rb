require 'rails_helper'

RSpec.describe "home/index.html.erb", type: :feature do
  describe 'basic functionality' do
    it 'has a login link' do
      visit root_path
      click_button("Login")
    end
    it 'has a new user link' do
      visit root_path
      click_button("New User")
    end
  
  end
end
