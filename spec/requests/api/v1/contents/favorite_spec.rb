require 'rails_helper'

describe 'POST api/v1/contents/:id/favorite', type: :request do
  let(:user) { create(:user) }

  context 'when the content is not flagged' do
    let!(:content)  { create(:content) }

    before(:each) do
      post favorite_api_v1_content_path(id: content.id), params: { favorited: true },
                                                         headers: auth_headers, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the content' do
      expect(json[:content][:id]).to eq(content.id)
    end

    it 'marks the content as favorited by the user' do
      heart = Heart.last
      expect(heart.user_id).to eq(user.id)
      expect(heart.content_id).to eq(content.id)
    end
  end

  context 'when the content is already favorited and tries to favorite it again' do
    let!(:content)   { create(:content) }
    let!(:favorite)  { create(:heart, user: user, content: content) }

    before(:each) do
      post favorite_api_v1_content_path(id: content.id), params: { favorited: true },
                                                         headers: auth_headers, as: :json
    end

    it 'returns fail' do
      expect(response).to have_http_status(:bad_request)
    end

    it "doesn't favorite the content twice by the same user" do
      favorites = Heart.where(user: user, content: content)
      expect(favorites.count).to eq(1)
    end
  end

  context 'when the content is already favorite and wants to unfavorite' do
    let!(:content)   { create(:content) }
    let!(:favorite)  { create(:heart, user: user, content: content) }

    before(:each) do
      post favorite_api_v1_content_path(id: content.id), params: { favorited: false },
                                                         headers: auth_headers, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'unfavorites the content' do
      favorites = Heart.where(user: user, content: content)
      expect(favorites.count).to eq(0)
    end
  end
end
