# == Schema Information
#
# Table name: articles
#
#  id                :integer          not null, primary key
#  user_id           :integer
#  title             :string           not null
#  content           :text             default("")
#  views_count       :integer
#  comments_count    :integer
#  status            :string
#  position          :integer
#  last_edited_at    :datetime
#  last_commented_at :datetime
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Article < ActiveRecord::Base
  extend Enumerize
  include ArticleSearchable
  include PublicActivity::Common

  enumerize :status, in: [
    :public,
    :draft,
    :trashed
  ], default: :public, predicates: true

  has_paper_trail on: [:update, :destroy],
    only: [:title, :content]
  acts_as_taggable
  acts_as_taggable_on :categories
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  validates :title, uniqueness: { scope: :user_id }
  validates :title, presence: true

  delegate :name, :email, to: :user, prefix: :user, allow_nil: true

  after_create :increase_counts
  after_destroy :decrease_counts

  private

  def increase_counts
    self.user.user_quotum.increment! :articles_count
  end

  def decrease_counts
    self.user.user_quotum.decrement! :articles_count
  end
end
