class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  GenderChoices = {
    0 => I18n.t('user.female'),
    1 => I18n.t('user.male')
  }
end
