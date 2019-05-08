# == Schema Information
#
# Table name: constellations
#
#  id         :integer          not null, primary key
#  name       :string
#  icon       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stories    :integer          default("0")
#

class Constellation < ApplicationRecord
  mount_base64_uploader :icon, IconUploader

  has_many :content_constellations, dependent: :destroy
  has_many :contents, through: :content_constellations

  validates :name, presence: true

  def self.to_dropdown_ordered
    order('LOWER(name)').map do |constellation|
      ["#{constellation.name.titleize}", constellation.id]
    end
  end

  def self.search(term)
    where('LOWER(name) like LOWER(?)', "%#{term.strip}%")
  end

  def refresh_stories_counter
    update!(stories: contents.allowed.count)
  end
end
