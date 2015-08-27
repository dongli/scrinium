class Publication < ActiveRecord::Base
  belongs_to :user
  belongs_to :reference
  validates_uniqueness_of :user_id, scope: :reference_id
end
