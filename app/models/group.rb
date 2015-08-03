class Group < ActiveRecord::Base
  has_many :group_user_associations
  has_many :users, through: :group_user_associations

  PrivacyTypes = {
    0 => I18n.t('group.privacy_types.public'),
    1 => I18n.t('group.privacy_types.private')
  }
end
