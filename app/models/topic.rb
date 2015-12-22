# == Schema Information
#
# Table name: topics
#
#  id                :integer          not null, primary key
#  group_id          :integer
#  node_id           :integer
#  user_id           :integer
#  title             :string
#  content           :text
#  views_count       :integer
#  comments_count    :integer
#  sticky            :boolean
#  essential         :boolean
#  status            :string
#  position          :integer
#  last_edited_at    :datetime
#  last_commented_at :datetime
#  deleted_at        :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Topic < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
  belongs_to :node
  has_many :comments, as: :commentable, dependent: :destroy

  delegate :name, :email, to: :user, prefix: :user, allow_nil: true
  delegate :name, to: :node, prefix: :node, allow_nil: true
end
