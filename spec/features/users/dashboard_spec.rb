require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  before :each do
    # user_login_data
    # user_select_loc_data
    # visit dashboard_path
  end

  it 'has a navbar' do
    VCR.use_cassette("navbar") do
      user_login_data
      user_select_loc_data
      visit dashboard_path
      # require 'pry'; binding.pry
      expect(page).to have_css('.navbar.navbar-light.bg-light')
      within('.navbar.navbar-light.bg-light') do
        expect(page).to have_selector('form[action="/third_spaces/search"]')
        expect(page).to have_button("Search")
      end
    end
  end
  
  xit 'allows the user to click the contact button and redirects to a form' do
    VCR.use_cassette("contact w redirect") do
      user_login_data
      user_select_loc_data
      visit dashboard_path
      expect(current_path).to eq '/dashboard'

      expect(page).to have_content('User Dashboard')
      expect(page).to have_button('contact us')

      expect(page).to have_link('contact us', href: new_contact_form_path)

    end
  end

  xit 'displays the logo' do
    expect(page).to have_css('a.navbar-brand img[src*="temp_logo.png"]')
  end

  xit 'expands the navbar on toggler click' do
    find('navbar-toggler').click
    expect(page).to have_css('#navbarSupportedContent.show')
  end

  xit "if there are not any locations near the user, the page will recommend adding one" do
    VCR.use_cassette("recommend location") do
      user_login_data
      user_select_loc_data
      visit dashboard_path
      expect(page).to have_content("Minneapolis, MN")
      expect(page).to have_content("No Third Spaces near you.")
      expect(page).to have_content("Add a location here.")
      expect(page).to have_link("here")
    end
  end

  xit "links to recommendations index" do
    VCR.use_cassette("recommendations index") do
    user_login_data
    user_select_loc_data
    visit dashboard_path
    expect(page).to have_link("Recommendations")
    click_link "Recommendations"
    require 'pry'; binding.pry
    expect(current_path).to eq(recommendations_path)
    end
  end
end
