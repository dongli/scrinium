# == Schema Information
#
# Table name: licenses
#
#  id              :integer          not null, primary key
#  organization_id :integer          not null
#  engine_name     :string           not null
#  expired_at      :string           not null
#  max_num_seats   :integer          default(5)
#  status          :string           default("unapproved")
#  position        :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

class LicenseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
