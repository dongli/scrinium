class Collection < ActiveRecord::Base
  belongs_to :user
  belongs_to :collectable, polymorphic: true
  validates_uniqueness_of :user_id, scope: [ :collectable_id, :collectable_type ]
end
