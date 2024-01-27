require 'rails_helper'

RSpec.describe PasswordResetsController, type: :controller do


  describe "POST #create" do
    let(:user) { create(:user, email: 'user@example.com') }
    context "when user exists" do
      it "sends a password reset email and redirects to login with a notice" do
        # Extend the mock_response to include .headers
        mock_response = double("Response", status_code: 202, body: 'email sent', headers: {})

        # Stub the SendGrid API call within the mailer and return the mock_response
        allow_any_instance_of(SendGrid::API).to receive_message_chain(:client, :mail, :_, :post).and_return(mock_response)

        expect {
          post :create, params: { email: user.email }
        }.to change { ActionMailer::Base.deliveries.count }.by(0) #Because of SendGrid

        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'If an account with that email was found, we have sent a link to reset password'
      end
    end
    context "when user does not exist" do
      it "redirects to login with a notice and does not send an email" do
        expect {
          post :create, params: { email: 'nonexistent@example.com' }
        }.to change { ActionMailer::Base.deliveries.count }.by(0)

        expect(response).to redirect_to('/login')
        expect(flash[:notice]).to eq 'If an account with that email was found, we have sent a link to reset password'
      end
    end
  end

  describe "GET #edit" do
    let(:user) { create(:user) }
    let(:token) { user.signed_id(purpose: 'password_reset', expires_in: 15.minutes) }

    context "with invalid token" do
      it "redirects to login with an alert" do
        get :edit, params: { token: 'invalid_token' }
        expect(response).to redirect_to('/login')
        expect(flash[:alert]).to eq 'Your token has expired. Please try again'
      end
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user) }
    let(:token) { user.signed_id(purpose: 'password_reset', expires_in: 15.minutes) }
    let(:new_password) { { password: 'newpassword123', password_confirmation: 'newpassword123' } }
    let(:invalid_params) { { password: 'short', password_confirmation: 'short1' } } 

    context "with invalid token" do
      it "redirects to login with an alert" do
        patch :update, params: { token: 'invalid_token', user: new_password }
        expect(response).to redirect_to('/login')
        expect(flash[:alert]).to eq 'Your token has expired. Please try again'
      end
    end
    context "when password update fails" do
      it "redirects and renders the edit template" do
        
        patch :update, params: { token: token, user: invalid_params }
        expect(response).to render_template("edit")

      end
    end
  end
  
end
