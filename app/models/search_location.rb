class SearchLocation < ApplicationRecord
  belongs_to :user

  validates :city, presence: { message: "City can't be blank" }
  validates :state, presence: { message: "State can't be blank" }  
  validates :mood, presence: true, allow_blank: true
end
