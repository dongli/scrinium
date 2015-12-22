# == Schema Information
#
# Table name: memberships
#
#  id              :integer          not null, primary key
#  description     :text
#  host_id         :integer          not null
#  host_type       :string           not null
#  user_id         :integer          not null
#  role            :string
#  expired_at      :datetime
#  join_type       :string
#  rejected_reason :text
#  rejected_at     :datetime
#  joined_at       :datetime
#  last_user_id    :integer
#  status          :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
