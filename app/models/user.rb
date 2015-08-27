class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_attached_file :avatar, styles: { medium: '150x150', thumb: '100x100', small: '20x20' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  validates_attachment_presence :avatar

  acts_as_messageable

  belongs_to :organization
  has_many :articles, dependent: :destroy
  has_many :group_user_associations
  has_many :groups, through: :group_user_associations
  has_many :comments, dependent: :destroy
  has_many :publications, dependent: :destroy
  has_many :references, through: :publications
  # TODO: Below is the special codes for LASG.
  has_many :experiments

  enum gender: [
    :female,
    :male
  ].map { |x| I18n.t("user.gender_types.#{x}") }
  enum role: [
    :super_admin,
    :admin,
    :user,
    :guest
  ].map { |x| I18n.t("user.role_types.#{x}") }
  enum position: [
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
  ].map { |x| I18n.t("user.position_types.#{x}") }

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
