# == Schema Information
#
# Table name: organizationships
#
#  id                 :integer          not null, primary key
#  organization_id    :integer
#  suborganization_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'test_helper'

class OrganizationshipTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
