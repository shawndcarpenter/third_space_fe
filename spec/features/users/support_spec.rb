require 'rails_helper'

RSpec.describe "support", type: :feature do
  describe 'basic functionality' do

    #This is going to need some tweaking, and the floating labels aren't necessary, I was just curious and thought they looked nice. 
    it 'has an support form' do
      visit support_path
      expect(page).to have_field("subject")
      expect(page).to have_field("message")
    end

    it 'has submit button' do
      visit support_path
      click_button "submit"

      #add path
    end
  
  end
end
