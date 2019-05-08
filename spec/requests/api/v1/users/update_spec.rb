require 'rails_helper'

describe 'PUT api/v1/user/', type: :request do
  let(:user)             { create(:user) }
  let(:api_v1_user_path) { '/api/v1/user' }

  context 'with valid params' do
    let(:params) {  { user: { username: 'new username' } } }

    it 'returns success' do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'updates the user' do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
      expect(user.reload.username).to eq(params[:user][:username])
    end

    it 'returns the user' do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
      expect(json[:user][:id]).to eq user.id
      expect(json[:user][:username]).to eq user.reload.username
    end
  end

  context 'with invalid data' do
    let(:params) { { user: { email: 'notanemail' } } }

    it 'does not return success' do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
      expect(response).to_not have_http_status(:success)
    end

    it 'does not update the user' do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
      expect(user.reload.email).to_not eq(params[:email])
    end

    it 'returns the error' do
      put api_v1_user_path, params: params, headers: auth_headers, as: :json
      expect(json[:errors][:email]).to include('is not an email')
    end
  end
end
