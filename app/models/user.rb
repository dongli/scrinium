# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  avatar                  :string
#  name                    :string           not null
#  email                   :string           not null
#  encrypted_password      :string           not null
#  gender                  :string           not null
#  position                :string
#  role                    :string           not null
#  status                  :string
#  current_organization_id :integer
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class User < ActiveRecord::Base
  extend Enumerize

  enumerize :gender, in: [ :female, :male ]
  enumerize :position, in: [
    :academician,
    :researcher,
    :associate_researcher,
    :assistant_researcher,
    :professor,
    :associate_professor,
    :assistant_professor,
    :postdoctoral_researcher,
    :postgraduate,
    :undergraduate,
    :freeman
  ]
  enumerize :role, in: [
    :admin,
    :assist_admin,
    :user,
    :guest
  ], default: :guest, predicates: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  mount_uploader :avatar, ImageUploader

  acts_as_messageable

  has_many :memberships, dependent: :destroy
  has_many :organizations, through: :memberships, source: :host, source_type: 'Organization'
  has_many :groups, through: :memberships, source: :host, source_type: 'Group'
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :references, through: :publications
  has_many :collections, dependent: :destroy
  has_many :resources, as: :resourceable, dependent: :destroy

  validates :avatar, file_size: { less_than_or_equal_to: 2.megabytes },
                     file_content_type: { allow: [ 'image/jpeg', 'image/png' ] }
  validates_presence_of :name, :gender

  def mailboxer_email object
    object.class == Mailboxer::Notification ? email : nil
  end
end
