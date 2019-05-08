require 'rails_helper'

describe 'GET api/v1/contents/favorites', type: :request do
  context 'when there are favorited contents' do
    let!(:contents)          { create_list(:content, 5) }
    let!(:hearted_contents)  { create_list(:content, 2) }
    let!(:user)              { create(:user, hearted_contents: hearted_contents) }

    before(:each) do
      get favorites_api_v1_contents_path, headers: auth_headers, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns all favorited contents' do
      expect(json[:contents].map { |content| content[:id] })
        .to match_array(hearted_contents.pluck(:id))
    end

    it 'does not return not favorited contents' do
      expect(json[:contents].map { |content| content[:id] })
        .to_not include(*contents.pluck(:id))
    end
  end
end
