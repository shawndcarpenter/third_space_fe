class SearchLocation < ApplicationRecord
  belongs_to :user

  validates :city, presence: { message: "City can't be blank" }
  validates :address, presence: { message: "Address can't be blank" }  
end
