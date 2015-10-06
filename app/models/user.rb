class User < ActiveRecord::Base
  extend Enumerize

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: '150x150', thumb: '100x100', small: '20x20' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  acts_as_messageable

  belongs_to :organization
  has_many :articles, dependent: :destroy
  has_many :group_user_associations
  has_many :groups, through: :group_user_associations
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
  enum role: [
    :super_admin,
    :admin,
    :user,
    :guest
  ].map { |x| I18n.t("user.role_types.#{x}") }

  validates :gender, exclusion: {
    in: [ I18n.t('user.gender_types.invalid') ],
    message: I18n.t('user.gender_is_empty')
  }

  before_save :set_user_defaults

  def mailboxer_email object
    object.class == Mailboxer::Notification ? email : nil
  end

  protected

  def set_user_defaults
    if not self.role
      if User.all.empty?
        # Set the first user as super admin!
        self.role = 0
      else
        self.role = 3
      end
    end
  end
end
