class UserMailer < ApplicationMailer
  default from: 'thirdspace2308@gmail.com'
  require 'sendgrid-ruby'
  include SendGrid

  def send_otp_email(user)
    @user = user

    sendgrid_api_key = Rails.application.credentials.dig(:sendgrid, :key)

    from = Email.new(email: 'thirdspace2308@gmail.com')
    to = Email.new(email: "#{@user.email}")
    subject = 'Your OTP'
    content = Content.new(type: 'text/plain', value: "Your OTP for Two-Factor Authentication at third space.
    Your OTP code is: #{@user.otp_code}")
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: sendgrid_api_key)
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end
end