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

FactoryGirl.define do
  factory :constellation_request do
    name    { Faker::Lorem.word }
    reason  { Faker::Lorem.sentence }
    user

    after(:create) do |constellation_request, _evaluator|
      create(
        :content,
        constellation_request: constellation_request,
        user: constellation_request.user
      )
    end
  end
end
