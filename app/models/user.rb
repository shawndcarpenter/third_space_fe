class User < ApplicationRecord

  has_many :user_locations
  has_many :locations, through: :user_locations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  validates_presence_of :password

  has_secure_password

  enum role: %w(default admin)

  def generate_otp_secret_key
    self.otp_secret_key = ROTP::Base32.random(6)
    save
  end

  def generate_otp
    ROTP::TOTP.new(otp_secret_key).now
  end

  # doesn't work: I manually set the sesssion cookie code to otp passcode
  # def valid_otp?(code)
  #   totp = ROTP::TOTP.new(otp_secret_key)
  #   totp.verify(code)
  # end
end