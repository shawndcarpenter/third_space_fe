class UserMailer < ApplicationMailer
  default from: 'thirdspace2308@gmail.com' # Set your default sender email address
  require 'sendgrid-ruby'
include SendGrid

  def send_otp_email(user)

sendgrid_api_key = Rails.application.credentials.dig(:sendgrid, :key)

from = Email.new(email: 'test@example.com')
to = Email.new(email: 'test@example.com')
subject = 'Sending with SendGrid is Fun'
content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
mail = Mail.new(from, subject, to, content)

sg = SendGrid::API.new(api_key: sendgrid_api_key)
response = sg.client.mail._('send').post(request_body: mail.to_json)
puts response.status_code
puts response.body
puts response.headers


    # @user = user
    # @otp = user.otp_code

    # mail(to: @user.email, subject: 'Your OTP for Two-Factor Authentication')
  end
end