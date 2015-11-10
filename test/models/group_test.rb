# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  logo       :string
#  admin_id   :integer
#  privacy    :string           not null
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
