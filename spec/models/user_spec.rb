require "rails_helper"

RSpec.describe User, type: :model do
  
  describe "relationships" do
    it { should have_one(:search_location) }
    it { should have_many(:user_locations) }
    it { should have_many(:locations).through(:user_locations) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should have_secure_password}
  end
end