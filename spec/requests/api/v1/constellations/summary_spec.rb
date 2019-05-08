require 'rails_helper'

describe 'GET api/v1/users/constellations/:id/summary', type: :request do
  let(:user)           { create(:user) }
  let!(:constellation)    { create(:constellation) }

  context 'when there are contents' do
    let!(:common_contents) { create_list(:content, 20, constellations: [constellation]) }

    let!(:popular_contents) do
      create_list(:content, 10, constellations: [constellation])
    end

    let!(:about_to_expire_contents) do
      create_list(:content, 10, :about_to_expire, constellations: [constellation])
    end

    before(:each) do
      popular_contents.each do |content|
        create_list(:heart, ENV['POPULAR_HEARTS'].to_i, content: content)
      end

      get summary_api_v1_constellation_path(id: constellation.id),
          headers: auth_headers,
          params: { constellation_id: constellation.id },
          as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all the three groups of contents' do
      expect(json).to have_key(:about_to_expire)
      expect(json).to have_key(:popular)
      expect(json).to have_key(:common)
    end

    it 'returns 15 common contents' do
      expect(json[:common].length).to eq(15)

      json[:common].each do |content|
        expect(common_contents.find { |c| c.id == content[:id] }).to be_present
      end
    end

    it 'returns 8 popular contents' do
      expect(json[:popular].length).to eq(8)

      json[:popular].each do |content|
        expect(popular_contents.find { |c| c.id == content[:id] }).to be_present
      end
    end

    it 'returns 5 about to expire contents' do
      expect(json[:about_to_expire].length).to eq(5)

      json[:about_to_expire].each do |content|
        expect(about_to_expire_contents.find { |c| c.id == content[:id] }).to be_present
      end
    end
  end
end
