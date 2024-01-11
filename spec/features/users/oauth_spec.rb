require 'rails_helper'

RSpec.describe "oauth", type: :feature do
  describe 'basic functionality' do
    it 'has oauth login option' do
      visit "/"
      expect(page).to have_content("Continue with Google")
    end

  end
end