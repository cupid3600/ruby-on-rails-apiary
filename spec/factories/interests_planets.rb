# == Schema Information
#
# Table name: interests_planets
#
#  id         :integer          not null, primary key
#  planet_id  :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_interests_planets_on_planet_id  (planet_id)
#  index_interests_planets_on_user_id    (user_id)
#

FactoryGirl.define do
  factory :interests_planet do
    
  end

end
