require 'rails_helper'

describe 'POST api/v1/contents/:id/flag', type: :request do
  let(:user) { create(:user) }

  context 'when the content is not flagged' do
    let!(:content)         { create(:content) }

    before(:each) do
      post flag_api_v1_content_path(id: content.id), headers: auth_headers, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the content' do
      expect(json[:content][:id]).to eq(content.id)
    end

    it 'marks the content as flagged by the user' do
      flag = Flag.last
      expect(flag.user_id).to eq(user.id)
      expect(flag.content_id).to eq(content.id)
    end
  end

  context 'when the content is already flagged' do
    let!(:content)         { create(:content) }
    let!(:flag)            { create(:flag, user: user, content: content) }

    before(:each) do
      post flag_api_v1_content_path(id: content.id), headers: auth_headers, as: :json
    end

    it 'returns fail' do
      expect(response).to have_http_status(:bad_request)
    end

    it "doesn't flag the content twice by the same user" do
      flags = Flag.where(user: user, content: content)
      expect(flags.count).to eq(1)
    end
  end
end
