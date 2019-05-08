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

class Content < ApplicationRecord
  belongs_to :user
  belongs_to :constellation_request, optional: true

  has_many :content_constellations, dependent: :destroy
  has_many :constellations, through: :content_constellations
  has_many :flags, dependent: :destroy
  has_many :hearts, dependent: :destroy

  validates :type, presence: true

  after_save :refresh_constellations_stories_counter, if: :saved_change_to_disable?
  after_create :notify_new_shooting_star, if: :shooting_star?

  scope :audios, -> { where(type: 'Audio') }
  scope :videos, -> { where(type: 'Video') }
  scope :newest, -> { order(id: :desc) }
  scope :flagged, -> { joins(:flags).distinct }
  scope :allowed, -> { where(disable: false, expired: false) }
  scope :blocked, -> { where(disable: true) }
  scope :expired, -> { where(expired: true) }
  scope :shooting_stars, -> { where(expired: false, shooting_star: true) }

  scope :not_about_to_expire, lambda {
    where.not("? - (#{Time.zone.now.yday} - EXTRACT(DOY FROM contents.created_at)) <= ?",
              ENV['DAYS_TO_EXPIRE'].to_i, ENV['DAYS_TO_ABOUT_EXPIRE'].to_i)
  }

  scope :popular, -> { where('hearts_count >= ?', ENV['POPULAR_HEARTS']) }

  scope :popular_not_about_to_expire, -> { popular.order('hearts_count DESC').not_about_to_expire }

  scope :unpopular, -> { where.not('hearts_count >= ?', ENV['POPULAR_HEARTS']) }

  scope :about_to_expire_not_popular, lambda {
    where('? - (? - EXTRACT(DOY FROM contents.created_at)) <= ?',
          ENV['DAYS_TO_EXPIRE'].to_i, Time.zone.now.yday, ENV['DAYS_TO_ABOUT_EXPIRE'].to_i)
      .unpopular.order('id ASC')
  }

  scope :popular_about_to_expire, lambda {
    popular.where('? - (? - EXTRACT(DOY FROM contents.created_at)) <= ?',
                  ENV['DAYS_TO_EXPIRE'].to_i, Time.zone.now.yday,
                  ENV['DAYS_TO_ABOUT_EXPIRE'].to_i).order('hearts_count DESC')
  }

  scope :about_to_expire, -> { popular_about_to_expire.union_all(about_to_expire_not_popular) }

  scope :common, -> { not_about_to_expire.unpopular.order('RANDOM()') }

  scope :to_expire, lambda {
    where('? - (? - EXTRACT(DOY FROM contents.created_at)) <= ?',
          ENV['DAYS_TO_EXPIRE'].to_i, Time.zone.now.yday, 0)
  }

  accepts_nested_attributes_for :constellations

  delegate :count, to: :flags, prefix: true

  def self.required_information
    includes(:constellations, :user, :flags, :hearts)
  end

  def flagged_by?(user)
    flags.map(&:user_id).include?(user.id)
  end

  def hearted_by?(user)
    hearts.map(&:user_id).include?(user.id)
  end

  def favorite(user)
    hearts.create!(user: user)
  end

  def unfavorite(user)
    hearts.find_by!(user: user).destroy
  end

  def expire!
    update!(expired: true)
  end

  def self.notify_shooting_stars
    shooting_stars.find_each(&:notify_new_shooting_star)
  end

  private

  def refresh_constellations_stories_counter
    constellations.each(&:refresh_stories_counter)
  end

  def notify_new_shooting_star
    ShootingStarsBroadcastJob.perform_later user_id, 'new_star'
  end
end
