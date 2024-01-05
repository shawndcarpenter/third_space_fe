require "rails_helper"

RSpec.describe Location, type: :model do
  
  describe "relationships" do
    it { should have_many(:user_locations) }
    it { should have_many(:users).through(:user_locations) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
end