# == Schema Information
#
# Table name: codes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  code       :string
#  expires_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_codes_on_user_id  (user_id)
#

FactoryGirl.define do
  factory :code do
    user nil
code "MyString"
expires_at "2019-05-17 13:08:11"
  end

end
