# class OtpVerificationController < ApplicationController
#   def initiate_verification
#     # Render the page with options to initiate OTP verification
#     user = current_user # Assuming you have a current_user method
#     user.generate_otp_secret_key
#     user.update(otp_code: user.generate_otp, otp_code_expires_at: 5.minutes.from_now)

#     # Send OTP via email (using ActionMailer or similar)
#     UserMailer.send_otp_email(user).deliver_now
#   end

#   def validate_otp
#     entered_otp = params[:otp]
#     if current_user.valid_otp?(entered_otp)
#       # Mark the user as verified, update the session, or perform any other necessary actions
#       redirect_to dashboard_path, notice: 'OTP verification successful!'
#     else
#       flash.now[:alert] = 'Invalid OTP. Please try again.'
#       render 'validate_otp_page'
#     end
#   end
# end