require 'rails_helper'

describe 'GET api/v1/users/constellations/:id/popular', type: :request do
  let(:user)           { create(:user) }
  let!(:constellation) { create(:constellation) }

  context 'when there are about_to_expire contents' do
    let!(:popular_contents) do
      create_list(:content, 10, constellations: [constellation])
    end

    before(:each) do
      popular_contents.each do |content|
        create_list(:heart, ENV['POPULAR_HEARTS'].to_i, content: content)
      end

      get popular_api_v1_constellation_path(id: constellation.id),
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

    it 'returns popular contents' do
      expect(json[:contents].length).to eq(popular_contents.length)

      json[:contents].each do |content|
        expect(popular_contents.find { |c| c.id == content[:id] }).to be_present
      end
    end
  end
end
