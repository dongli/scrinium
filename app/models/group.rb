class Group < ActiveRecord::Base
  has_many :group_user_associations
  has_many :users, through: :group_user_associations
  has_many :group_research_record_associations
  has_many :research_records, through: :group_research_record_associations

  PrivacyTypes = {
    0 => I18n.t('privacy_types.public'),
    1 => I18n.t('privacy_types.private')
  }.freeze
end
