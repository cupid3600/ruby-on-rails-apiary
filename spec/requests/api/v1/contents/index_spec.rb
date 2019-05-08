require 'rails_helper'

describe 'GET api/v1/contents', type: :request do
  let(:user)           { create(:user) }

  context 'when there are contents' do
    let!(:constellation)    { create(:constellation) }
    let!(:contents)         { create_list(:content, 5, constellations: [constellation]) }
    let!(:disable_contents) do
      create_list(:content, 2, constellations: [constellation], disable: true)
    end

    before(:each) do
      get api_v1_contents_path, headers: auth_headers,
                                params: { constellation_id: constellation.id, page: 1 }, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all enable contents' do
      expect(json[:contents].map { |content| content[:id] })
        .to match_array(contents.pluck(:id))
    end

    it 'does not return disable contents' do
      expect(json[:contents].map { |content| content[:id] })
        .to_not include(*disable_contents.pluck(:id))
    end
  end
end
