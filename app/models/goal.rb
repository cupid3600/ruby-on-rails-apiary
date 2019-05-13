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

class Goal < ApplicationRecord
  scope :is_deleted, ->(is_deleted) { where(is_deleted: is_deleted) }
end
