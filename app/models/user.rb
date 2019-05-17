# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  tokens                 :json
#  username               :string
#  picture                :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  mount_base64_uploader :picture, ImageUploader

  has_many :videos, dependent: :destroy
  has_many :audios, dependent: :destroy
  has_many :contents, dependent: :destroy
  has_many :flags, dependent: :destroy
  has_many :hearts, dependent: :destroy
  has_many :hearted_contents, through: :hearts, source: :content
  has_many :constellation_requests
  has_many :interests_constellations
  has_many :interests_planets
  has_many :codes

  validates :uid, uniqueness: { scope: :provider }
  validates :username, uniqueness: true

  before_validation :init_uid

  def send_reset_password_code_email(opts={})
    code = self.codes.new(code: opts[:code])
    code.save

    UserMailer.reset_password_code_email(code).deliver
    code
  end

  private

  def uses_email?
    provider == 'email' || email.present?
  end

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end
end
