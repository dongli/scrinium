# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string           not null
#  content    :text             default("")
#  privacy    :string           not null
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Article < ActiveRecord::Base
  extend Enumerize
  # include ArticleSearchable

  validates :title, uniqueness: { scope: :user_id }
  validates :title, presence: true

  has_paper_trail on: [:update, :destroy],
    if: Proc.new { |article| article.finished? },
    only: [:title, :content]
  acts_as_taggable
  acts_as_taggable_on :categories
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  enumerize :privacy, in: [
    :public,
    :private
  ], default: :public, predicates: true

  enumerize :status, in: [
    :draft,
    :finished
  ], predicates: true

  delegate :name, :email, to: :user, prefix: :user, allow_nil: true
end
