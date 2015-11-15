# == Schema Information
#
# Table name: organizations
#
#  id         :integer          not null, primary key
#  logo       :string
#  admin_id   :integer
#  parent_id  :integer
#  website    :string
#  status     :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
