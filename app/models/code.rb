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

class Code < ApplicationRecord
  belongs_to :user

  before_create :assign_expires_at

  private
    def assign_expires_at
      self.expires_at ||= Time.current+10.minutes
    end
end
