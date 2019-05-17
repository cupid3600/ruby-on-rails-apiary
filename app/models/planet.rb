# == Schema Information
#
# Table name: planets
#
#  id               :integer          not null, primary key
#  title            :string           not null
#  icon             :string
#  is_approved      :boolean          default("false"), not null
#  is_deleted       :boolean          default("false"), not null
#  constellation_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_planets_on_constellation_id  (constellation_id)
#

class Planet < ApplicationRecord
  belongs_to :constellation
  has_many :interests_planet

  scope :by_deleted, ->(is_deleted) { where(is_deleted: is_deleted) }
  scope :by_approved, ->(is_approved) { where(is_approved: is_approved) }
  scope :by_constellation, ->(constellation_id) { where(:constellation_id => constellation_id) }

end
