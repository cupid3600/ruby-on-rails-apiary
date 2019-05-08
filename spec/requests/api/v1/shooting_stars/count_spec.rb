require 'rails_helper'

describe 'GET api/v1/shooting_stars/count', type: :request do
  let(:user) { create(:user) }

  context 'when there are shooting stars' do
    let!(:shooting_stars) { create_list(:content, 5, :shooting_star) }

    before(:each) do
      get api_v1_count_path, headers: auth_headers, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the amount of shooting stars' do
      expect(json[:shooting_stars_count]).to eq 5
    end
  end
end
