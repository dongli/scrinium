# == Schema Information
#
# Table name: organizations
#
#  id                :integer          not null, primary key
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  admin_id          :integer
#  website           :string
#  parent_id         :integer
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class OrganizationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
