require 'rails_helper'

RSpec.describe 'Privacy View', type: :feature do
  it 'displays the privacy and security policy' do
    visit privacy_path  

    expect(page).to have_content('Privacy & Security Policy')
    expect(page).to have_content('Information Collection')
    expect(page).to have_content('Use of Information')

    expect(page).to have_selector('h2', text: 'Privacy & Security Policy')
    expect(page).to have_selector('h4', text: 'Information Collection')
  end
end
