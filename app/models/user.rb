class User < ActiveRecord::Base
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: '150x150', thumb: '100x100', small: '20x20' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

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
  has_many :surveys, dependent: :destroy

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

  def mailboxer_email object
    object.class == Mailboxer::Notification ? email : nil
  end
end
