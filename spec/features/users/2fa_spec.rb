require 'rails_helper'

RSpec.describe "2fa", type: :feature do
  describe 'basic functionality' do
    it 'requires 2fa for new user' do
      visit "/register"
      fill_in "first_name", with: "a"
      fill_in "last_name", with: "a"
      fill_in "email", with: "email@gmail.com"
      fill_in "password", with: "a"
      fill_in "confirm_password", with: "a"
      click_button "create new account"
      expect(current_path).to eq "/validate_otp"
    end

    it 'requires 2fa for login' do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      expect(current_path).to eq "/validate_otp"
    end

    it '2fa works and can be validated' do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      email = ActionMailer::Base.deliveries.first
      email_body = email.body.decoded
      otp_code_match = email_body.match(/Your OTP code is: (\d+)/)
      otp_code = otp_code_match[1]
      fill_in "otp", with: otp_code.to_i
      click_button "Submit"
      expect(current_path).to eq "/"
    end

    it 'mailer mails email' do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
end