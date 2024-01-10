require 'rails_helper'

RSpec.describe GeolocationStorageController, type: :controller do
  describe 'POST #lat_lon_session' do
    context 'with valid geolocation data' do
      let(:valid_geolocation_data) do
        { latitude: 40.7128, longitude: -74.0060 }
      end

      it 'stores geolocation data in the session' do
        post :lat_lon_session, params: valid_geolocation_data

        expect(session[:lat].to_f).to eq(valid_geolocation_data[:latitude])
        expect(session[:lon].to_f).to eq(valid_geolocation_data[:longitude])
      end

    end

    context 'with invalid geolocation data' do
      let(:invalid_geolocation_data) do
        { latitude: 'invalid', longitude: 'invalid' }
      end

      it 'does not store geolocation data in the session' do
        post :lat_lon_session, params: invalid_geolocation_data

        expect(session[:lat]).to eq("invalid")
        expect(session[:lon]).to eq("invalid")
      end

    end
  end
end
