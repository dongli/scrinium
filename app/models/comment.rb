class Comment < ActiveRecord::Base
  validates :content, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  acts_as_tree dependent: :destroy
end
