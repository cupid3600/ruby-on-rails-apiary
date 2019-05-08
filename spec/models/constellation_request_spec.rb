# == Schema Information
#
# Table name: constellation_requests
#
#  id         :integer          not null, primary key
#  reason     :string
#  name       :string
#  status     :integer          default("0")
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_constellation_requests_on_user_id  (user_id)
#

require 'rails_helper'

describe ConstellationRequest, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:reason) }

  describe '#accept!' do
    let!(:constellation_request) { create :constellation_request }

    it 'changes the status to accepted' do
      constellation_request.accept!
      expect(constellation_request.reload.accepted?).to be true
    end

    it 'creates the constellation' do
      expect { constellation_request.accept! }.to change(Constellation, :count).by(1)
    end

    it 'assigns the content to the new constellation' do
      constellation = constellation_request.accept!
      expect(constellation.reload.stories).to eq 1
    end

    context 'when there are multiples requests for the same constellation name' do
      let!(:requests) do
        create_list :constellation_request, 5, name: constellation_request.name
      end

      it 'creates only one constellation' do
        expect { constellation_request.accept! }.to change(Constellation, :count).by(1)
      end

      it 'assign all contents to the constellation' do
        constellation = constellation_request.accept!
        expect(constellation.reload.stories).to eq 6
      end
    end
  end

  describe '#reject!' do
    let!(:constellation_request) { create :constellation_request }

    it 'changes the status to rejected' do
      constellation_request.reject!
      expect(constellation_request.reload.rejected?).to be true
    end

    it 'does not create the constellation' do
      expect { constellation_request.reject! }.not_to change(Constellation, :count)
    end
  end
end
