# == Schema Information
#
# Table name: memberships
#
#  id         :integer          not null, primary key
#  host_id    :integer          not null
#  host_type  :string           not null
#  user_id    :integer          not null
#  role       :string           default("member"), not null
#  expired_at :string
#  status     :string           default("unapproved")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
