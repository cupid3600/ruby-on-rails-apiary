
require 'rails_helper'

describe 'PUT api/v1/contents/:id/constellations', type: :request do
  let!(:user) { create :user }
  let!(:content) { create :content }
  let!(:constellation) { create :constellation }

  let(:params) do
    {
      constellation_ids: [constellation.id]
    }
  end

  context 'when the content is not in the constellation' do
    it 'returns a successful response' do
      put constellations_api_v1_content_path(content), params: params,
                                                       headers: auth_headers,
                                                       as: :json
      expect(response).to have_http_status(:success)
    end

    it 'associates the content to the constellation' do
      expect do
        put constellations_api_v1_content_path(content), params: params,
                                                         headers: auth_headers,
                                                         as: :json
      end.to change(content.content_constellations, :count).by(1)
    end
  end

  context 'when the content is already in a constellation' do
    let!(:content_constellation) do
      create :content_constellation, content: content, constellation: constellation
    end

    it 'returns a successful response' do
      put constellations_api_v1_content_path(content), params: params,
                                                       headers: auth_headers,
                                                       as: :json
      expect(response).to have_http_status(:success)
    end

    it 'does not create an association between the content and constellation' do
      expect do
        put constellations_api_v1_content_path(content), params: params,
                                                         headers: auth_headers,
                                                         as: :json
      end.not_to change(content.content_constellations, :count)
    end
  end
end
