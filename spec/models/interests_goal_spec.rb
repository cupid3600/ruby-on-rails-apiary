# == Schema Information
#
# Table name: interests_goals
#
#  id         :integer          not null, primary key
#  goal_id    :integer          not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_interests_goals_on_goal_id  (goal_id)
#  index_interests_goals_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe InterestsGoal, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
