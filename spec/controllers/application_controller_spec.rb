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
  let(:yelp_id) { "some-yelp-id" }
  let(:mock_reviews) { [double("Review", content: "Great place!")] } 
    before do
      # Route for mock controller's action
      routes.draw { get 'test_find_show_reviews' => 'anonymous#test_find_show_reviews' }
      allow_any_instance_of(LocationReviewsFacade).to receive(:reviews).and_return(mock_reviews)
    end
    it "returns reviews for a given Yelp ID" do
      get :test_find_show_reviews, params: { yelp_id: yelp_id }
      expect(response.body).to eq mock_reviews.to_json
    end
    describe "rescue in #current_user" do
    before do
      routes.draw { get 'test_current_user' => 'anonymous#test_current_user' }
    end
    it "resets session if user is not found" do
      session[:user_id] = 11111111111111111
      expect { get :test_current_user }.to change { session[:user_id] }.from(11111111111111111).to(nil)
      expect(response.body).to eq "false"
    end
    end
  end
end
