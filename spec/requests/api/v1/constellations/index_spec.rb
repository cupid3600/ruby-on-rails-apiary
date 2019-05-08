require 'rails_helper'

describe 'GET api/v1/users/constellations', type: :request do
  let(:user)           { create(:user) }

  context 'when there are constellations' do
    let!(:constellations) { create_list(:constellation, 5) }

    it 'returns success' do
      get api_v1_constellations_path, headers: auth_headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'returns all the constellations' do
      get api_v1_constellations_path, headers: auth_headers, as: :json
      expect(json[:constellations].map { |constellation| constellation[:name] })
        .to match_array(constellations.pluck(:name))
    end
  end
end
