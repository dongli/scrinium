# == Schema Information
#
# Table name: groups
#
#  id            :integer          not null, primary key
#  logo          :string
#  admin_id      :integer
#  status        :string
#  members_count :integer
#  topics_count  :integer
#  nodes_count   :integer
#  position      :integer
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class GroupSerializer < BaseSerializer
  attributes :id
end
