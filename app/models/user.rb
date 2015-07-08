class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  Genders = {
    0 => I18n.t('user.female'),
    1 => I18n.t('user.male')
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

  before_save :set_user_defaults

  def set_user_defaults
    if self.id == 1
      # Set the first user as super admin!
      self.role = 0
    else
      self.role = 3
    end
  end
end
