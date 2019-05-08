# == Schema Information
#
# Table name: content_constellations
#
#  id               :integer          not null, primary key
#  content_id       :integer
#  constellation_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_content_constellations_on_constellation_id  (constellation_id)
#  index_content_constellations_on_content_id        (content_id)
#

class ContentConstellation < ApplicationRecord
  belongs_to :constellation
  belongs_to :content

  after_save :refresh_constellation_stories_counter
  after_destroy :refresh_constellation_stories_counter

  private

  def refresh_constellation_stories_counter
    constellation.refresh_stories_counter
  end
end
