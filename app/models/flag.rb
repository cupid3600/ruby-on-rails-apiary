# == Schema Information
#
# Table name: flags
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_flags_on_content_id  (content_id)
#  index_flags_on_user_id     (user_id)
#

class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :content

  validates :content, uniqueness: { scope: :user }

  after_create :check_block_content

  scope :last_twenty_four, -> { where('created_at > ?', 24.hours.ago) }

  private

  def check_block_content
    content.update!(disable: true) if content.flags_count >= 3
  end
end
