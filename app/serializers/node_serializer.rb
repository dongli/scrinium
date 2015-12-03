# == Schema Information
#
# Table name: nodes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  name       :string
#  group_id   :integer
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class NodeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :group_id, :status, :position
end
