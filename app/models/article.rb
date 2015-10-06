class Article < ActiveRecord::Base
  extend Enumerize

  validates_uniqueness_of :title, scope: :user_id
  validates :title, presence: true
  validates_presence_of :privacy

  is_impressionable
  has_paper_trail on: [:update, :destroy],
    if: Proc.new { |t| not t.draft },
    only: [:title, :content]
  acts_as_taggable
  acts_as_taggable_on :categories
  belongs_to :user
  has_many :group_article_associations
  has_many :groups, through: :group_article_associations
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  enumerize :privacy, in: [
    :public,
    :private,
    :group_public
  ]
end
