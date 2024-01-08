class User < ApplicationRecord

  has_one :search_location
  has_many :user_locations
  has_many :locations, through: :user_locations

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  #validates :password, presence: true
  validates_inclusion_of :provider, in: [true, false]


  #has_secure_password

  enum role: %w(default admin)

  STATE_ACRONYMS = [
    'AL', 'AK', 'AZ', 'AR', 'CA', 'CO', 'CT', 'DE', 'FL', 'GA', 'HI', 'ID', 'IL', 'IN', 'IA', 'KS', 'KY', 'LA',
    'ME', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'OH', 'OK',
    'OR', 'PA', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 'VT', 'VA', 'WA', 'WV', 'WI', 'WY'
  ]

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

  def self.setup_password_security(user)
    if user.provider == true
      has_secure_password validations: false
    else
      has_secure_password
      validates :password, presence: true
    end
  end
end