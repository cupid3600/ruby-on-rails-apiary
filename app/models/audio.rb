# == Schema Information
#
# Table name: contents
#
#  id                       :integer          not null, primary key
#  file                     :string
#  user_id                  :integer
#  type                     :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  disable                  :boolean          default("false")
#  hearts_count             :integer          default("0")
#  expired                  :boolean          default("false")
#  shooting_star            :boolean          default("false")
#  constellation_request_id :integer
#
# Indexes
#
#  index_contents_on_constellation_request_id  (constellation_request_id)
#  index_contents_on_shooting_star             (shooting_star)
#  index_contents_on_user_id                   (user_id)
#

class Audio < Content
  mount_uploader :file, AudioUploader
end
