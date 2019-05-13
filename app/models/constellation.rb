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

class Constellation < ApplicationRecord
  mount_base64_uploader :icon, IconUploader

  has_many :content_constellations, dependent: :destroy
  has_many :contents, through: :content_constellations
  has_many :planets
  has_many :interests_constellations
  validates :name, presence: true

  scope :is_deleted, ->(is_deleted) { where(is_deleted: is_deleted) }
  scope :show_on_sign_up, ->(show_on_sign_up) { where(show_on_sign_up: show_on_sign_up) }
  scope :both, ->(show_on_sign_up, is_deleted) { where(show_on_sign_up: show_on_sign_up, is_deleted: is_deleted) }

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
