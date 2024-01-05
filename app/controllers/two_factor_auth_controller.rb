# class TwoFactorAuthController < ApplicationController
#   def send_otp
#     user = current_user # Assuming you have a current_user method
#     user.generate_otp_secret_key
#     user.update(otp_code: user.generate_otp, otp_code_expires_at: 5.minutes.from_now)

#     # Send OTP via email (using ActionMailer or similar)
#     UserMailer.send_otp_email(user).deliver_now

#     redirect_to root_path, notice: 'OTP sent successfully!'
#   end
# end