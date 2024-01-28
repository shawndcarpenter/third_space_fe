require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #dashboard" do
    context "when user is not logged in" do
      it "redirects to the root path" do
        get :dashboard
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is logged in" do
      let(:user) { create(:user) }
      let(:search_location) { create(:search_location, user: user) }


      
    end
  end

  describe "GET #show" do
    let(:user) { create(:user) }

    context "when not logged in" do
      it "redirects to root path with an error flash message" do
        get :show, params: { user_id: user.id }
        expect(response).to redirect_to("/")
        expect(flash[:error]).to eq("Must be logged in to view your dashboard.")
      end
    end
  end

  describe "POST #create" do
    let(:user_params) { { user: attributes_for(:user) } }

    context "with valid parameters" do
      it "creates a new user and redirects to validate_otp_path", :vcr do
        expect {
          post :create, params: user_params
        }.to change(User, :count).by(1)
        expect(response).to redirect_to(validate_otp_path)
      end
    end

    context "with invalid parameters" do
      before { user_params[:user][:email] = "" }

      it "does not create a user and redirects to register path" do
        expect {
          post :create, params: user_params
        }.not_to change(User, :count)
        expect(response).to redirect_to("/register")
      end
    end
  end

  describe "POST #login" do
    let!(:user) { create(:user, password: 'password') }

    context "with valid credentials" do
      it "sets the user in the session and redirects", :vcr do
        post :login, params: { email: user.email, password: 'password' }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(validate_otp_path)
      end
    end

    context "with invalid credentials" do
      it "renders the login_form with an error flash message" do
        post :login, params: { email: user.email, password: 'wrong' }
        expect(response).to render_template(:login_form)
        expect(flash[:error]).to eq("Sorry, your credentials are bad.")
      end
    end
  end
end
