# == Schema Information
#
# Table name: constellations
#
#  id              :integer          not null, primary key
#  name            :string
#  icon            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  stories         :integer          default("0")
#  show_on_sign_up :boolean          default("false")
#  is_deleted      :boolean          default("false")
#

FactoryGirl.define do
  factory :constellation do
    name { Faker::Lorem.word }
  end
end
