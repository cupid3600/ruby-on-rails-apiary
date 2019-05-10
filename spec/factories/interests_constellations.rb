# == Schema Information
#
# Table name: interests_constellations
#
#  id               :integer          not null, primary key
#  constellation_id :integer          not null
#  user_id          :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_interests_constellations_on_constellation_id  (constellation_id)
#  index_interests_constellations_on_user_id           (user_id)
#

FactoryGirl.define do
  factory :interests_constellation do
    
  end

end
