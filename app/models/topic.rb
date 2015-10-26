class Topic < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :topicable, polymorphic: true

  validates :topicable_id, :topicable_type, uniqueness: { scope: :group_id }
end
