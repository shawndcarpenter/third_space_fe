class Location < ApplicationRecord
  has_many :user_locations
  has_many :users, through: :user_locations

  validates :name, presence: true
  validates :address, presence: true
  validates :latitude, presence: true
  validates :longitude, presence: true
end