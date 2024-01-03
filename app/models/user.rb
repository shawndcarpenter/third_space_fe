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
end