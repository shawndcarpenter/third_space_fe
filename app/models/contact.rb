class Contact < ApplicationRecord
  validates :subject, presence: true
  validates :description, presence: true
end
