class ResearchRecord < ActiveRecord::Base
  validates_uniqueness_of :title, scope: :user_id
  validates :title, :content, presence: true
  is_impressionable
  has_paper_trail
  belongs_to :user
  has_many :group_research_record_associations
  has_many :groups, through: :group_research_record_associations

  enum privacy: [
    :public,
    :private,
    :group_public
  ].map { |x| I18n.t("privacy_types.#{x}") }
end
