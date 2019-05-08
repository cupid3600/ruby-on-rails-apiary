require 'rails_helper'

describe 'GET api/v1/users/constellations/:id/common', type: :request do
  let(:user)           { create(:user) }
  let!(:constellation) { create(:constellation) }

  context 'when there are common contents' do
    let!(:common_contents) { create_list(:content, 20, constellations: [constellation]) }

    before(:each) do
      get common_api_v1_constellation_path(id: constellation.id),
          headers: auth_headers,
          params: { constellation_id: constellation.id },
          as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the contents inside a contents key' do
      expect(json).to have_key(:contents)
    end

    it 'returns common contents' do
      expect(json[:contents].length).to eq(common_contents.length)

      json[:contents].each do |content|
        expect(common_contents.find { |c| c.id == content[:id] }).to be_present
      end
    end
  end
end
