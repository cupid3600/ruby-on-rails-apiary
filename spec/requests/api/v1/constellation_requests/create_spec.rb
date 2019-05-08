
require 'rails_helper'

describe 'POST api/v1/constellation_requests/', type: :request do
  let!(:user) { create :user }
  let!(:admin) { create :admin_user }
  let!(:audio) do
    fixture_file_upload("#{fixture_path}/files/sample_audio.mp3", 'audio/mp3')
  end

  let(:params) do
    {
      constellation_request:
        {
          name: Faker::Lorem.word,
          reason: Faker::Lorem.sentence,
          content_attributes: {
            file: audio
          }
        }
    }
  end

  context 'with valid params' do
    it 'returns a successful response' do
      post api_v1_constellation_requests_path, params: params, headers: auth_headers
      expect(response).to have_http_status(:success)
    end

    it 'creates the request for the user' do
      expect do
        post api_v1_constellation_requests_path, params: params, headers: auth_headers
      end.to change(user.constellation_requests, :count).by(1)
    end

    it 'sends an email to notify that a new request was made' do
      expect do
        post api_v1_constellation_requests_path, params: params, headers: auth_headers
      end.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    context 'when the constellation already exists' do
      let!(:constellation) { create :constellation, name: params[:constellation_request][:name] }

      it 'returns bad_request' do
        post api_v1_constellation_requests_path, params: params, headers: auth_headers
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  context 'with invalid params' do
    before(:each) { params[:constellation_request][:name] = nil }

    it 'returns bad_request' do
      post api_v1_constellation_requests_path, params: params, headers: auth_headers
      expect(response).to have_http_status(:bad_request)
    end
  end
end
