# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  name                    :string           not null
#  email                   :string           not null
#  mobile                  :string
#  encrypted_password      :string           not null
#  role                    :string           not null
#  current_organization_id :integer
#  position                :integer
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  confirmation_token      :string
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  unconfirmed_email       :string
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class User < ActiveRecord::Base
  extend Enumerize

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
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :references, through: :publications
  has_many :collections, dependent: :destroy
  has_many :resources, as: :resourceable, dependent: :destroy
  has_many :folders, as: :folderable, dependent: :destroy
  has_one  :profile, dependent: :destroy
  accepts_nested_attributes_for :profile, allow_destroy: true

  validates :name, :email, presence: true
  validates :email, uniqueness: true
  validates_associated :profile

  # TODO: 或者把创建根目录的任务拖延到用户第一次使用资源管理的时候。
  after_create :create_root_folder

  def mailboxer_email object
    object.class == Mailboxer::Notification ? email : nil
  end

  def avatar_url
    self.profile.try(:avatar)
  end

  def create_root_folder
    self.folders.create(name: 'root', user_id: self.id, folderable_id: self.id, folderable_type: 'User')
  end
end
