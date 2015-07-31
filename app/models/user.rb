class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :organization
  belongs_to :research_team
  Genders = {
    0 => I18n.t('user.genders.female'),
    1 => I18n.t('user.genders.male')
  }.freeze
  Positions = {
    :researcher => I18n.t('user.positions.researcher'),
    :associate_researcher => I18n.t('user.positions.associate_researcher'),
    :post_doctor => I18n.t('user.positions.post_doctor'),
    :student => I18n.t('user.positions.student')
  }.freeze
  Roles = {
    0 => I18n.t('user.roles.super_admin'),
    1 => I18n.t('user.roles.admin'),
    2 => I18n.t('user.roles.user'),
    3 => I18n.t('user.roles.guest')
  }.freeze

  def super_admin?
    self.role == 0
  end

  def admin?
    self.role == 1 || super_admin?
  end

  def user?
    self.role == 2 || admin?
  end

  def guest?
    self.role == 3
  end

  before_save :set_user_defaults

  protected

  def set_user_defaults
    if self.id == 1
      # Set the first user as super admin!
      self.role = 0
    else
      self.role = 3
    end
  end
end
