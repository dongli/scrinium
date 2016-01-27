# == Schema Information
#
# Table name: collections
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  collectable_id   :integer
#  collectable_type :string
#  status           :string
#  position         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Collection < ActiveRecord::Base
  belongs_to :user
  belongs_to :collectable, polymorphic: true
  validates :user_id, uniqueness: { cope: [ :collectable_id, :collectable_type ] }
end
