require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  # Mock controller to test ApplicationController methods
  controller do
    def test_current_user
      render plain: current_user.present?.to_s
    end

    def test_current_admin
      render plain: current_admin?.to_s
    end

    def test_find_show_reviews
      reviews = find_show_reviews(params[:yelp_id])
      render json: reviews
    end
  end

  describe "#current_user" do
    before do
      # Route for mock controller's action
      routes.draw { get 'test_current_user' => 'anonymous#test_current_user' }
      # routes.draw { get 'test_current_admin' => 'anonymous#test_current_admin' }
    end

    it "returns the current user if one is logged in" do
      user = create(:user) 
      session[:user_id] = user.id

      get :test_current_user
      expect(response.body).to eq "true"
    end

    it "returns nil if no user is logged in" do
      get :test_current_user
      expect(response.body).to eq "false"
    end
  end

  describe "#current_admin?" do
    before do
      # Route for mock controller's action
      routes.draw { get 'test_current_admin' => 'anonymous#test_current_admin' }
    end

    it "returns true if current user is an admin" do
      admin = create(:user, role: 'admin')
      session[:user_id] = admin.id

      get :test_current_admin
      expect(response.body).to eq "true"
    end

    it "returns false if current user is not an admin" do
      user = create(:user, role: 'default')
      session[:user_id] = user.id

      get :test_current_admin
      expect(response.body).to eq "false"
    end
  end

  describe "#find_show_reviews" do
    before do
      # Route for mock controller's action
      routes.draw { get 'test_find_show_reviews' => 'anonymous#test_find_show_reviews' }
    end

    xit "fetches reviews for a given location" do
      # Mock the external HTTP request
      yelp_id = "Ovrji3x2PMuY8G0rOcrrNA"
      stub_request(:get, "http://localhost:3000/api/v1/locations/#{yelp_id}/reviews")
        .to_return(status: 200, body: { data: [{ attributes: { content: "Great place!" } }] }.to_json)

      get :test_find_show_reviews, params: { yelp_id: yelp_id }

      expect(response.body).to include "Great place!"
    end
  end
end
