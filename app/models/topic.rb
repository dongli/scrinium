class Topic < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  belongs_to :topicable, polymorphic: true
end
