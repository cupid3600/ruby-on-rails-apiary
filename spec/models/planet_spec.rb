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

require 'rails_helper'

RSpec.describe Planet, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
