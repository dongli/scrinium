# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  description     :text
#  host_id         :integer          not null
#  host_type       :string           not null
#  user_id         :integer          not null
#  role            :string           default("member")
#  expired_at      :datetime
#  join_type       :string
#  rejected_reason :text
#  rejected_at     :datetime
#  joined_at       :datetime
#  last_user_id    :integer
#  status          :string           default("unapproved")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class MembershipSerializer < ActiveModel::Serializer
  attributes :id
end
