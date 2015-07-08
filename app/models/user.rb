class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum genders: [
    I18n.t('user.female'),
    I18n.t('user.male')
  ]
  enum positions: [
    I18n.t('user.positions.researcher'),
    I18n.t('user.positions.associate_researcher'),
    I18n.t('user.positions.post_doctor'),
    I18n.t('user.positions.student')
  ]
  enum roles: [
    I18n.t('user.roles.super_admin'),
    I18n.t('user.roles.admin'),
    I18n.t('user.roles.user'),
    I18n.t('user.roles.guest')
  ]
end
