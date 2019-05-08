# == Schema Information
#
# Table name: constellations
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stories    :integer          default("0")
#

require 'rails_helper'

describe Constellation  do
  describe 'search' do
    let(:matched_constellation_1)   { create(:constellation, name: 'Matched_const') }
    let(:matched_constellation_2)   { create(:constellation, name: 'Matched_const_2') }
    let!(:unmatched_constellation_1) { create(:constellation, name: 'unmatched') }
    let!(:case_insensitive_match_1)      { create(:constellation, name: 'CASE_insensitive_match') }
    let!(:case_insensitive_match_2)      { create(:constellation, name: 'case_insensitive_match') }

    it 'retrieves only the matched constellations' do
      matched_collection = matched_constellation_1, matched_constellation_2
      expect(Constellation.search('const')).to eq(matched_collection)
    end

    it 'matches with case insensitive' do
      matched_collection = case_insensitive_match_1, case_insensitive_match_2
      expect(Constellation.search('case')).to eq(matched_collection)
      expect(Constellation.search('CASE')).to eq(matched_collection)
    end
  end
end
