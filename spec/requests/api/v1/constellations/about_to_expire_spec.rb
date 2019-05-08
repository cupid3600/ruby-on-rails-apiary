require 'rails_helper'

describe 'GET api/v1/users/constellations/:id/about_to_expire', type: :request do
  let(:user)           { create(:user) }
  let!(:constellation) { create(:constellation) }

  context 'when there are about_to_expire contents' do
    let!(:about_to_expire_contents) do
      create_list(:content, 10, :about_to_expire, constellations: [constellation])
    end

    before(:each) do
      get about_to_expire_api_v1_constellation_path(id: constellation.id),
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

    it 'returns all the contents about to expire' do
      expect(json[:contents].length).to eq(about_to_expire_contents.length)

      json[:contents].each do |content|
        expect(about_to_expire_contents.find { |c| c.id == content[:id] }).to be_present
      end
    end
  end
end
