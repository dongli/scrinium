class ResearchRecord < ActiveRecord::Base
  validates_uniqueness_of :title, scope: :user_id
  validates :title, :content, presence: true
  is_impressionable
  has_paper_trail
  belongs_to :user
end
