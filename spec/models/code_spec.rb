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

require 'rails_helper'

RSpec.describe Code, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
