require 'rails_helper'

describe 'GET api/v1/shooting_star/show_one', type: :request do
  let(:user) { create(:user) }

  context 'when there are shooting stars' do
    let!(:shooting_stars) { create_list(:content, 5, :shooting_star) }

    before(:each) do
      get api_v1_show_one_path, headers: auth_headers, as: :json
    end

    it 'returns success' do
      expect(response).to have_http_status(:success)
    end

    it 'marks the shooting star as expired' do
      star_id = json[:shooting_star][:id]
      expect(Content.find(star_id)).to be_expired
    end
  end
end
