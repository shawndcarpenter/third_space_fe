require "rails_helper"

RSpec.describe "User Search of Locations for Creation", type: :feature do 
  before :each do
  end

  describe "General Third Space details displayed" do 
    xit "lists the the general details including name, open status, tags, description, address, and hours" do
      expect(page).to have_content("Five Watt Coffee")
    end

  end
end