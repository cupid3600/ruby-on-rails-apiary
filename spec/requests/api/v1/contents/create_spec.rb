
require 'rails_helper'

describe 'POST api/v1/contents/', type: :request do
  include ActiveJob::TestHelper

  let(:user) { create(:user) }

  describe 'POST create' do
    let!(:constellation) { create(:constellation) }

    let!(:audio) do
      fixture_file_upload("#{fixture_path}/files/sample_audio.mp3", 'audio/mp3')
    end

    let!(:video) do
      fixture_file_upload("#{fixture_path}/files/sample3.mp4", 'video/mp4')
    end

    let!(:wrong) do
      fixture_file_upload("#{fixture_path}/files/profile.png", 'image/png')
    end

    %w(audio video wrong).each do |file_type|
      let("params_#{file_type}".to_sym) do
        {
          content:
            {
              constellation_ids: [constellation.id],
              file: eval(file_type)
            }
        }
      end
    end

    before(:each) do
      Rails.application.eager_load!
    end

    it 'returns a successful response' do
      post api_v1_contents_path, params: params_audio, headers: auth_headers
      expect(response).to have_http_status(:success)
    end

    context 'when creating a new audio' do
      it 'creates the audio' do
        expect do
          post api_v1_contents_path, params: params_audio, headers: auth_headers
        end.to change(user.audios, :count).by(1)
      end

      it 'creates an audio type file' do
        post api_v1_contents_path, params: params_audio, headers: auth_headers
        expect(json[:content][:id]).to eq(Content.last.id)
        expect(Content.last.type).to eq('Audio')
      end

      it 'uploads the correct audio' do
        post api_v1_contents_path, params: params_audio, headers: auth_headers
        content_file = "#{Rails.root}/tmp/#{Content.last.file.url}"
        file_uploaded = fixture_file_upload("#{fixture_path}/files/sample_audio.mp3")
        expect(content_file).to be_same_file_as(file_uploaded)
      end
    end

    context 'when creating a new video' do
      it 'creates the video' do
        expect do
          post api_v1_contents_path, params: params_video, headers: auth_headers
        end.to change(user.videos, :count).by(1)
      end

      it 'creates an video type file' do
        post api_v1_contents_path, params: params_video, headers: auth_headers
        expect(json[:content][:id]).to eq(Content.last.id)
        expect(Content.last.type).to eq('Video')
      end

      it 'uploads the correct video' do
        post api_v1_contents_path, params: params_video, headers: auth_headers
        content_file = "#{Rails.root}/tmp/#{Content.last.file.url}"
        file_uploaded = fixture_file_upload("#{fixture_path}/files/sample3.mp4")
        expect(content_file).to be_same_file_as(file_uploaded)
      end
    end

    context 'when creating a shooting star' do
      let!(:another_user) { create :user }
      before(:each) { params_audio[:content][:shooting_star] = true }

      it 'returns a successful response' do
        post api_v1_contents_path, params: params_audio, headers: auth_headers
        expect(response).to have_http_status(:success)
      end

      it 'creates a content as a shooting star' do
        expect do
          post api_v1_contents_path, params: params_audio, headers: auth_headers
        end.to change(Content.shooting_stars, :count).by(1)
      end

      it 'notify new shooting star' do
        expect do
          post api_v1_contents_path, params: params_audio, headers: auth_headers
        end.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
      end
    end

    context 'when tries to create wrong content' do
      it 'returns bad request status' do
        post api_v1_contents_path, params: params_wrong, headers: auth_headers
        expect(response).to have_http_status(:bad_request)
      end

      it 'does not create new content' do
        expect do
          post api_v1_contents_path, params: params_wrong, headers: auth_headers
        end.to_not change(user.contents, :count)
      end
    end
  end
end
