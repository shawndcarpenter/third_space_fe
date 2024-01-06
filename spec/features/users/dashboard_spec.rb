require 'rails_helper'

RSpec.describe 'User Dashboard', type: :feature do
  let(:user) { create(:user) }

  before :each do
    @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
    visit '/login'
    fill_in "email", with: "#{@user1.email}"
    fill_in "password", with: "#{@user1.password}"
    click_button "log in"
    email = ActionMailer::Base.deliveries.last
    email_body = email.body.decoded
    otp_code_match = email_body.match(/Your OTP code is: (\d+)/)
    otp_code = otp_code_match[1]
    fill_in "otp", with: otp_code.to_i
    click_button "submit"
    expect(current_path).to eq "/dashboard"
  end

  it 'allows the user to contact support' do
    expect(page).to have_content('User Dashboard')
    expect(page).to have_button('Contact Us')

    click_button 'Contact Us'

    expect(current_path).to eq(new_contact_form_path) # Replace with your actual path

    fill_in 'Subject', with: 'Test Subject'
    fill_in 'Description', with: 'Description Issue'

    click_button 'Submit'

    expect(current_path).to eq('/dashboard')
    expect(page).to have_content('Your message has been submitted successfully')
  end
end
