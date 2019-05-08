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

class ConstellationRequest < ApplicationRecord
  belongs_to :user
  has_one :content

  validates :name, :reason, presence: true

  enum status: { pending: 0, accepted: 1, rejected: 2 }

  accepts_nested_attributes_for :content

  scope :with_name, -> (name) { where(name: name) }

  def accept!
    requests = self.class.with_name(name)
    requests.update_all(status: 'accepted')
    constellation = create_constellation(requests)
    requests.each { |request| UserMailer.accepted_constellation(request).deliver_later }

    constellation
  end

  def reject!
    requests = self.class.with_name(name)
    requests.update_all(status: 'rejected')

    requests.each { |request| UserMailer.rejected_constellation(request).deliver_later }
  end

  private

  def create_constellation(requests)
    Constellation.find_or_create_by!(name: name).tap do |constellation|
      contents = Content.where(constellation_request_id: requests.pluck(:id))

      contents.each do |content|
        content.content_constellations.find_or_create_by!(constellation_id: constellation.id)
      end
    end
  end
end
