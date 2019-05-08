# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  slug       :string           not null
#  title      :string           not null
#  is_deleted :boolean          default("false")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_goals_on_slug  (slug)
#

require 'rails_helper'

RSpec.describe Goal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
