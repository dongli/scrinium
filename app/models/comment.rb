# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  commentable_id   :integer
#  commentable_type :string
#  content          :text             not null
#  parent_id        :integer
#  floor            :integer
#  status           :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
  acts_as_tree dependent: :destroy

  belongs_to :commentable, polymorphic: true
  belongs_to :user

  validates :content, presence: true
  validates :floor, uniqueness: { scope: [:commentable_type, :commentable_id] }
end
