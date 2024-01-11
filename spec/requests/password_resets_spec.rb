require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/password/reset"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    it "returns http success" do
      get "/password/reset"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/password/reset/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    it "returns http success" do
      patch "/password/reset/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
