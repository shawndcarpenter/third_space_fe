require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe "GET #index" do
    let(:name) { "Coffee Shop" }
    let(:city) { "Denver" }
    let(:location_results) { [double("Location")] }  

    before do
      allow(LocationsFacade).to receive(:new).and_return(double(locations: location_results))
    end

    it "assigns @location_results", :vcr do
      get :index, params: { name: name, city: city }

      expect(assigns(:location_results)).to eq(location_results)
    end
  end
  describe "GET #show" do
    let(:location_id) { "1" }
    let(:location) { double("Location") }
    let(:reviews) { [double("Review")] }  

    before do
      allow(LocationFacade).to receive(:new).and_return(double(location: location))
      allow(LocationReviewsFacade).to receive(:new).and_return(double(reviews: reviews))
    end

    it "assigns @location, @location_json, and @reviews" do
      get :show, params: { id: location_id }

      expect(assigns(:location)).to eq(location)
      expect(assigns(:location_json)).to eq(location.to_json)
      expect(assigns(:reviews)).to eq(reviews)
    end
  end
end
