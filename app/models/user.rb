# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  email                  :string           not null
#  mobile                 :string
#  encrypted_password     :string           not null
#  role                   :string           not null
#  position               :integer
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  authentication_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  include Resourceable
  extend Enumerize
  include UserSearchable
  enumerize :role, in: [:admin, :assist_admin, :user], default: :user, predicates: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :trackable,
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :confirmable if Rails.env.production?

  acts_as_messageable

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships, source: :host, source_type: 'Organization'
  has_many :groups, through: :memberships, source: :host, source_type: 'Group'
  has_many :active_relationships, class_name: 'Relationship', dependent: :destroy, foreign_key: :follower_id
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: 'Relationship', dependent: :destroy, foreign_key: :followed_id
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :references, through: :publications
  has_many :collections, dependent: :destroy
  has_one  :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates_associated :profile

  before_create :create_default_profile
  before_save :ensure_authentication_token

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def mailboxer_email object
    object.class == Mailboxer::Notification ? email : nil
  end

  def avatar_url
    self.profile.try(:avatar)
  end

  def reset_authentication_token
    self.authentication_token = SecureRandom.uuid
    self.save
  end

  private

  def create_default_profile
    self.build_profile
  end

  def generate_authentication_token
    self.authentication_token = SecureRandom.uuid
  end
end
