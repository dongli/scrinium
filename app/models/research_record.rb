class ResearchRecord < ActiveRecord::Base
  validates_uniqueness_of :title, scope: :user_id
  validates :title, :content, presence: true
  is_impressionable
  has_paper_trail
  belongs_to :user
  has_many :group_research_record_associations
  has_many :groups, through: :group_research_record_associations

  PrivacyTypes = {
    I18n.t('privacy_types.public')       => 0,
    I18n.t('privacy_types.private')      => 1,
    I18n.t('privacy_types.group_public') => 2
  }.freeze
end
