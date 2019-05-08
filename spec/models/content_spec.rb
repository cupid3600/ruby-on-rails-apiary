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

require 'rails_helper'

def heart_contents(contents)
  contents.each_with_index do |content, iter|
    create_list(:heart, popular_hearts + iter, content: content)
  end
end

describe Content do
  let(:days_to_expire)          { ENV['DAYS_TO_EXPIRE'].to_i }
  let(:days_to_about_to_expire) { ENV['DAYS_TO_ABOUT_EXPIRE'].to_i }
  let(:popular_hearts)          { ENV['POPULAR_HEARTS'].to_i }

  describe '#refresh_constellations_stories_counter' do
    let!(:constellation) { create(:constellation) }
    let!(:content_one) { create(:content, disable: false, constellations: [constellation]) }
    let!(:content_two) { create(:content, disable: false, constellations: [constellation]) }

    context 'when a new disable content is created' do
      it 'does not change constellation stories counter' do
        expect do
          create(:content, disable: true, constellations: [constellation])
        end.to_not change { constellation.stories }
      end
    end

    context 'when the content is disabled' do
      it 'decreases constellation stories counter' do
        expect do
          content_one.update(disable: true)
        end.to change { constellation.stories }.from(2).to(1)
      end
    end
  end

  describe '#flagged_by' do
    let!(:user) { create(:user) }
    let!(:content_one) { create(:content) }
    let!(:content_two) { create(:content) }
    let!(:flag) { create(:flag, content: content_one, user: user) }

    context 'when the content is already flagged by the user' do
      it 'returns true' do
        expect(content_one.reload.flagged_by?(user)).to eq(true)
      end
    end

    context 'when the content is already flagged by the user' do
      it 'returns false' do
        expect(content_two.flagged_by?(user)).to eq(false)
      end
    end
  end

  describe '.about_to_expire_not_popular' do
    let!(:contents_about_to_expire) { create_list(:content, 2, :about_to_expire).map(&:id) }

    let!(:contents_not_expiring) { create_list(:content, 2).map(&:id) }

    let!(:popular_contents_about_to_expire) { create_list(:content, 2, :about_to_expire) }

    let(:about_to_expire_not_popular) { Content.about_to_expire_not_popular.pluck(:id) }

    before(:each) do
      heart_contents(popular_contents_about_to_expire)
    end

    it 'returns only the contents about to expire' do
      expect(about_to_expire_not_popular).to match_array(contents_about_to_expire)
      expect(about_to_expire_not_popular).not_to include(contents_not_expiring)
    end

    it 'does not return the popular contents' do
      expect(about_to_expire_not_popular).not_to include(popular_contents_about_to_expire.map(&:id))
    end

    it 'returns the contents ordered by antiquity' do
      expect(about_to_expire_not_popular).to eq contents_about_to_expire.sort
    end
  end

  describe '.not_about_to_expire' do
    let!(:contents_about_to_expire) { create_list(:content, 2, :about_to_expire).map(&:id) }

    let!(:contents_not_expiring) { create_list(:content, 2).map(&:id) }

    let(:not_about_to_expire) { Content.not_about_to_expire.pluck(:id) }

    it 'returns only the contents not about to expire' do
      expect(not_about_to_expire).to match_array(contents_not_expiring)
      expect(not_about_to_expire).not_to include(contents_about_to_expire)
    end
  end

  describe '.popular_not_about_to_expire' do
    let!(:popular_contents)   { create_list(:content, 2) }
    let!(:unpopular_contents) { create_list(:content, 2) }

    let!(:popular_contents_about_to_expire) { create_list(:content, 2, :about_to_expire) }

    let(:popular_not_about_to_expire) { Content.popular_not_about_to_expire.pluck(:id) }

    before(:each) do
      heart_contents(popular_contents_about_to_expire + popular_contents)
    end

    it 'returns only the popular contents' do
      expect(popular_not_about_to_expire).to match_array(popular_contents.map(&:id))
      expect(popular_not_about_to_expire).not_to include(unpopular_contents.map(&:id))
    end

    it 'does not return popular content about to expire' do
      expect(popular_not_about_to_expire).not_to include(popular_contents_about_to_expire.map(&:id))
    end

    it 'returns the popular contents ordered by hearts' do
      expect(popular_not_about_to_expire)
        .to eq popular_contents.sort_by(&:hearts_count).reverse.map(&:id)
    end
  end

  describe '.unpopular' do
    let!(:popular_contents)   { create_list(:content, 2) }
    let!(:unpopular_contents) { create_list(:content, 2) }

    let(:unpopular) { Content.unpopular.pluck(:id) }

    before(:each) do
      heart_contents(popular_contents)
    end

    it 'returns only the unpopular contents' do
      expect(unpopular).to match_array(unpopular_contents.map(&:id))
      expect(unpopular).not_to include(popular_contents.map(&:id))
    end
  end

  describe '.popular_about_to_expire' do
    let!(:popular_contents)   { create_list(:content, 2) }

    let!(:contents_about_to_expire) { create_list(:content, 2, :about_to_expire).map(&:id) }

    let!(:popular_contents_about_to_expire) { create_list(:content, 2, :about_to_expire) }

    before(:each) do
      heart_contents(popular_contents + popular_contents_about_to_expire)
    end

    let!(:popular_and_about_to_expire) { Content.popular_about_to_expire.pluck(:id) }

    it 'returns only the contents about to expire' do
      expect(popular_and_about_to_expire).to match_array(popular_contents_about_to_expire.map(&:id))
      expect(popular_and_about_to_expire).not_to include(popular_contents.map(&:id))
      expect(popular_and_about_to_expire).not_to include(contents_about_to_expire)
    end

    it 'returns the contents ordered by hearts' do
      expect(popular_and_about_to_expire)
        .to eq popular_contents_about_to_expire.sort_by(&:hearts_count).reverse.map(&:id)
    end
  end

  describe '.about_to_expire' do
    let!(:contents_about_to_expire) { create_list(:content, 2, :about_to_expire).map(&:id) }

    let!(:popular_contents_about_to_expire) { create_list(:content, 2, :about_to_expire) }

    before(:each) do
      heart_contents(popular_contents_about_to_expire)
    end

    let!(:about_to_expire) { Content.about_to_expire.pluck(:id) }

    it 'returns all the contents about to expire' do
      expect(about_to_expire)
        .to match_array(contents_about_to_expire + popular_contents_about_to_expire.map(&:id))
    end

    it 'returns firstly the popular contents ordered by hearts' do
      expect(about_to_expire.first(2))
        .to eq popular_contents_about_to_expire.sort_by(&:hearts_count).reverse.map(&:id)
    end

    it 'returns secondly the about to expire unpopular contents ordered by antiquity' do
      expect(about_to_expire.last(2)).to eq contents_about_to_expire
    end
  end

  describe '.common' do
    let!(:popular_contents)   { create_list(:content, 2) }

    let!(:contents_about_to_expire) { create_list(:content, 2, :about_to_expire).map(&:id) }

    let!(:common_content) { create_list(:content, 2).map(&:id) }

    before(:each) do
      heart_contents(popular_contents)
    end

    let!(:common) { Content.common.pluck(:id) }

    it 'returns only the common content (not popular and not about to expire)' do
      expect(common).to match_array(common_content)
      expect(common).not_to include(popular_contents.map(&:id))
      expect(common).not_to include(contents_about_to_expire)
    end
  end
end
