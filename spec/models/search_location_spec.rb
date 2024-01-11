require "rails_helper"

RSpec.describe SearchLocation, type: :model do
  
  describe "relationships" do
    it { should belong_to(:user) }
  end

  describe "validations" do
    it { should validate_presence_of(:city).with_message("City can't be blank") }
    it { should validate_presence_of(:state).with_message("State can't be blank") }
    it { should validate_presence_of(:mood).allow_blank }
  end
end