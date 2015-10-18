# == Schema Information
#
# Table name: groups
#
#  id                :integer          not null, primary key
#  admin_id          :integer
#  privacy           :string           not null
#  logo_file_name    :string
#  logo_content_type :string
#  logo_file_size    :integer
#  logo_updated_at   :datetime
#  status            :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
