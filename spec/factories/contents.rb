# == Schema Information
#
# Table name: contents
#
#  id                       :integer          not null, primary key
#  file                     :string
#  user_id                  :integer
#  type                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  disable                  :boolean          default("false")
#  hearts_count             :integer          default("0")
#  expired                  :boolean          default("false")
#  shooting_star            :boolean          default("false")
#  constellation_request_id :integer
#
# Indexes
#
#  index_contents_on_constellation_request_id  (constellation_request_id)
#  index_contents_on_shooting_star             (shooting_star)
#  index_contents_on_user_id                   (user_id)
#

FactoryGirl.define do
  factory :content, class: :Content do
    user
    type %w(Audio Video).sample
    file do
      path = Rails.root, 'spec', 'fixtures', 'files',
             type == 'Audio' ? 'sample_audio.mp3' : 'sample3.mp4'
      Rack::Test::UploadedFile.new(File.join(path))
    end

    trait :about_to_expire do
      created_at { (ENV['DAYS_TO_EXPIRE'].to_i - ENV['DAYS_TO_ABOUT_EXPIRE'].to_i).days.ago }
    end

    trait :shooting_star do
      shooting_star { true }
    end
  end

  factory :video, parent: :content, class: :Video do
  end

  factory :audio, parent: :content, class: :Audio do
  end
end
