class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  belongs_to :research_team
  has_many :research_records
  has_many :group_user_associations
  has_many :groups, through: :group_user_associations
  has_many :comments, dependent: :destroy
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
