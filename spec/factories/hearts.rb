# == Schema Information
#
# Table name: hearts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_hearts_on_content_id  (content_id)
#  index_hearts_on_user_id     (user_id)
#

FactoryGirl.define do
  factory :heart do
    user
    content
  end
end
