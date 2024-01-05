class UserMailer < ApplicationMailer
  default from: 'thirdspace2308@gmail.com' # Set your default sender email address

  def send_otp_email(user)
    @user = user
    @otp = user.otp_code

    mail(to: @user.email, subject: 'Your OTP for Two-Factor Authentication')
  end
end