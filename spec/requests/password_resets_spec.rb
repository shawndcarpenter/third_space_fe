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
    let(:user) do
      User.create(
        first_name: "Testing",
        last_name: "Dude",
        email: "to@example.org",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    it "returns http success" do
      get "/password/reset/edit", params: { token: user.signed_id(purpose: 'password_reset', expires_in: 15.minutes) }
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    let(:user) do
      User.create(
        first_name: "Testing",
        last_name: "Dude",
        email: "to@example.org",
        password: "password123",
        password_confirmation: "password123"
      )
    end

    it "returns http success" do
      patch "/password/reset/edit", params: { token: user.signed_id(purpose: 'password_reset', expires_in: 15.minutes), user: { password: 'new_password', password_confirmation: 'new_password' } }
      expect(response).to have_http_status(:redirect)
    end
  end

end
