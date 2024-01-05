class UserLocation < ApplicationRecord
  belongs_to :user
  belongs_to :location
  validates :user_id, presence: true, numericality: true
  validates :location_id, presence: true, numericality: true
end