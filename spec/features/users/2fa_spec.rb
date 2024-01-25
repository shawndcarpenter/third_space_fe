require 'rails_helper'

RSpec.describe "2fa", type: :feature do
  describe 'basic functionality' do
    it 'requires 2fa for new user', :vcr do
      visit "/register"
      fill_in "first name", with: "a"
      fill_in "last name", with: "a"
      fill_in "email", with: "email@gmail.com"
      fill_in "password", with: "a"
      fill_in "password confirmation", with: "a"
      click_button "create new account"
      expect(current_path).to eq "/validate_otp"
    end

    it 'requires 2fa for login', :vcr do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      expect(current_path).to eq "/validate_otp"
    end

    it '2fa works and can be validated', :vcr do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      # email = ActionMailer::Base.deliveries.last
      # email_body = email.body.decoded
      # otp_code_match = email_body.match(/Your OTP code is: (\d+)/)
      # otp_code = otp_code_match[1]
      # fill_in "otp", with: otp_code.to_i
      fill_in 'otp', with: Rails.application.config.x.static_otp
      click_button "submit"
      expect(current_path).to eq "/set_location"
    end

    xit 'mailer mails email', :vcr do #figure out better way to test
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      expect(ActionMailer::Base.deliveries.count).to eq(1)
    end
  end
  describe 'sad path testing' do
    #can't figure out how to get this to work because delivery status occurs in log after submission attempt
    xit 'mailer error' do
      #@user = User.create(first_name: "Candy", last_name: "Land", email: "d.co@z.com", password: "test", otp_code: 123456, otp_code_expires_at:5.minutes.from_now)
      #UserMailer.send_otp_email(@user).deliver_now
      # expect(ActionMailer::Base.deliveries.count).to eq(0)
      # email = ActionMailer::Base.deliveries.last
      binding.pry
      # expect(email).to
    end

    it 'wrong 2fa for new user', :vcr  do
      visit "/register"
      fill_in "first name", with: "c"
      fill_in "last name", with: "c"
      fill_in "email", with: "cmail@gmail.com"
      fill_in "password", with: "c"
      fill_in "password confirmation", with: "c"
      click_button "create new account"
      fill_in "otp", with: 1
      click_button "submit"
      expect(page).to have_content("Invalid OTP. Please try again.")
      expect(current_path).to eq "/validate_otp"
    end

    it 'wrong 2fa for login', :vcr  do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      fill_in "otp", with: 1
      click_button "submit"
      expect(page).to have_content("Invalid OTP. Please try again.")
      expect(current_path).to eq "/validate_otp"
    end

    it 'timed out 2fa', :vcr  do
      @user1 = User.create(first_name: "Candy", last_name: "Land", email: "shawncarpenter.co@gmail.com", password: "test")
      visit "/login"
      fill_in "email", with: "#{@user1.email}"
      fill_in "password", with: "#{@user1.password}"
      click_button "log in"
      # email = ActionMailer::Base.deliveries.last
      # email_body = email.body.decoded
      # otp_code_match = email_body.match(/Your OTP code is: (\d+)/)
      # otp_code = otp_code_match[1]
      # fill_in "otp", with: otp_code.to_i
      fill_in 'otp', with: Rails.application.config.x.static_otp
      allow(Time).to receive(:now).and_return(6.minutes.from_now)
      click_button "submit"
      expect(page).to have_content("OTP session has expired. Please try logging in again.")
      expect(current_path).to eq "/login"
    end
  end
end