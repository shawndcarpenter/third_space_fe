class PasswordMailer < ApplicationMailer
  default from: 'thirdspace2308@gmail.com'

  require 'sendgrid-ruby'
  include SendGrid

  def reset
    @user = params[:user]
    @token = @user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)

    sendgrid_api_key = Rails.application.credentials.dig(:sendgrid, :key)

    from = Email.new(email: 'thirdspace2308@gmail.com')
    to = Email.new(email: @user.email)
    subject = 'Reset Your Password'


    reset_link = "http://localhost:5000/password/reset/edit?token=#{@token}"
    content_value = "Please reset your password by clicking the link: #{reset_link}. This link will expire in 15 minutes."
    content = Content.new(type: 'text/plain', value: content_value)

    mail = Mail.new(from, subject, to, content)
    tracking_settings = TrackingSettings.new
    click_tracking = ClickTracking.new(enable: false, enable_text: false)
    tracking_settings.click_tracking = click_tracking
    mail.tracking_settings = tracking_settings

    sg = SendGrid::API.new(api_key: sendgrid_api_key)
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    puts response.status_code
    puts response.body
    puts response.headers
  end
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  # def reset
  #   @user = params[:user]
  #   @token = @user.signed_id(purpose: 'password_reset', expires_in: 15.minutes)

  #   mail(to: @user.email, subject: 'Reset Your Password') do |format|
  #     format.html { render 'reset', locals: { host: default_url_options[:host] } }
  #   end.deliver
  # end
end
