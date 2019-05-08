require 'rails_helper'

describe 'GET api/v1/users/constellations/search', type: :request do
  let(:user)           { create(:user) }

  context 'when there are constellations' do
    let!(:constellation_1)           { create(:constellation, name: 'constellation_1') }
    let!(:constellation_2)           { create(:constellation, name: 'constellation_2') }
    let!(:another_constellation_1)   { create(:constellation, name: 'not_matching') }
    let!(:another_constellation_2)   { create(:constellation, name: 'not_matching_2') }
    let(:params)                     { { constellation: 'const' } }

    it 'returns success' do
      get search_api_v1_constellations_path, headers: auth_headers, params: params, as: :json
      expect(response).to have_http_status(:success)
    end

    it 'returns only the matched constellations' do
      constellations = constellation_1, constellation_2
      unmatched_constellations = another_constellation_1, another_constellation_2
      get search_api_v1_constellations_path, headers: auth_headers, params: params, as: :json

      expect(json[:constellations].map { |constellation| constellation[:name] })
        .to match_array(constellations.pluck(:name))

      expect(json[:constellations].map { |constellation| constellation[:name] })
        .not_to match_array(unmatched_constellations.pluck(:name))
    end
  end
end
