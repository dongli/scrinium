# == Schema Information
#
# Table name: nodes
#
#  id            :integer          not null, primary key
#  name          :string
#  group_id      :integer
#  parent_id     :integer
#  status        :string
#  position      :integer
#  on_group_page :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class NodeSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :group_id, :status, :position
end
