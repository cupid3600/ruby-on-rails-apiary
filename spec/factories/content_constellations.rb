# == Schema Information
#
# Table name: content_constellations
#
#  id               :integer          not null, primary key
#  content_id       :integer
#  constellation_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_content_constellations_on_constellation_id  (constellation_id)
#  index_content_constellations_on_content_id        (content_id)
#

FactoryGirl.define do
  factory :content_constellation do
    constellation
    content
  end
end
